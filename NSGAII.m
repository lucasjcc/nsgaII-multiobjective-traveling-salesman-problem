clear all;
close all;
clc;

%Medição do tempo de execução
tic

%% Definições do algoritmo

%Dados da distância, tempo e dificuldade do percurso entre as cidades
Datasets.distancia = table2array(readtable('distancia.csv'));
Datasets.tempo = table2array(readtable('tempo.csv'));
load dificuldade.mat;
Datasets.dificuldade = dificuldade;

%Parâmetros iniciais
Parametros.tamanhoPopulacao = 50;
Parametros.numeroCidades = 250;
Parametros.probabilidadeMutacao = 0.8;
Parametros.quantidadeGeracoes = 1000;
Parametros.passosCalculoIndicadores = round(Parametros.quantidadeGeracoes/10);
Parametros.divisor2opt=100;

%Dados relacionados à fronteira estimada pelo AG
Pontos.utopico = [21.8 1231];
Pontos.antiutopico = [23.7 1255];
Pontos.extremoSuperior = [21.8 1255];
Pontos.extremoInferior = [23.7 1231];

%Indicadores
indexIndicadores = 1;
delta = [];
hipervolume = [];

%Fronteira ótima
fronteiraOtima = [];

%% Início do NSGA- II

%Gerar população inicial
populacao = gerar_populacao(Parametros);

%Cálculo da aptidão de cada indivíduo
for i = 1:Parametros.tamanhoPopulacao
    populacao(i).fitness = fitness(populacao(i),Parametros,Datasets);
end

%Classificação da população em ranks
[populacao, fronteira] = classificacao_dominancia(populacao);

% Cálculo da distância de aglomeração
populacao = distancia_aglomeracao(populacao,fronteira);

%Ordenamento da população pelo rank e distância de aglomeração,
%respectivamente
[populacao, fronteira] = classificacao_populacao(populacao);

geracao = 1;
%Realizar as etapas do algoritmo até completar a quantidade de gerações
while geracao < Parametros.quantidadeGeracoes
           
    %Vencedores do torneio
    paisCampeoes = torneio(populacao);

    %Realizar o cruzamento entre os vencedores do torneio
    filhos = crossover(paisCampeoes,Parametros);
    
    %Realizar mutação
    filhos = mutacao(filhos,Parametros);

    %Cálculo da aptidão dos filhos
    quantidadeFilhos = numel(filhos);
    for i = 1:quantidadeFilhos
        filhos(i).fitness = fitness(filhos(i),Parametros,Datasets);
    end

    %Inserir os filhos na população
    populacao = [populacao filhos];  
    
    %Classificação da população em ranks
    [populacao, fronteira] = classificacao_dominancia(populacao);

    % Cálculo da distância de aglomeração
    populacao = distancia_aglomeracao(populacao,fronteira);

    %Ordenamento da população pelo rank e distância de aglomeração,
    %respectivamente
    [populacao, fronteira] = classificacao_populacao(populacao);

    %Excluir os N piores indivíduos da população
    tamanhoPopulacao = numel(populacao);
    populacao = populacao(1:tamanhoPopulacao/2);
    
    %Classificação da população em fronteiras
    [populacao, fronteira] = classificacao_dominancia(populacao);

    % Cálculo da distância de aglomeração
    populacao = distancia_aglomeracao(populacao,fronteira);

    %Ordenamento da população
    [populacao, fronteira] = classificacao_populacao(populacao);
    
    %Aplicar busca local (2 opt)
    if(mod(geracao,Parametros.divisor2opt)==0 || geracao==1)    
       
        for i=1:numel(fronteira{1})
            [populacao(fronteira{1}(i)).representacao,L]=two_opt(populacao(fronteira{1}(i)).representacao,Datasets.distancia,Datasets.tempo);
        end
        
        %Cálculo da aptidão de cada indivíduo
        for i = 1:Parametros.tamanhoPopulacao
            populacao(i).fitness = fitness(populacao(i),Parametros,Datasets);
        end
        
        %Classificação da população em ranks
        [populacao, fronteira] = classificacao_dominancia(populacao);
        
        % Cálculo da distância de aglomeração
        populacao = distancia_aglomeracao(populacao,fronteira);
        
        %Ordenamento da população pelo rank e distância de aglomeração,
        %respectivamente
        [populacao, fronteira] = classificacao_populacao(populacao);
    end
       
    %Fronteira ótima encontrada até o momento
    fronteiraOtima = populacao(fronteira{1});
    
%     %Calcular o parâmetro ∆ em 10 momentos distintos 
    if mod (geracao,Parametros.passosCalculoIndicadores) == 0 || geracao == 1
        hipervolume(indexIndicadores) = indicador_hipervolume(fronteiraOtima,Pontos);
        delta(indexIndicadores) = indicador_delta(fronteiraOtima,Pontos);
        figure(1)
        plot(delta,'-x','MarkerSize',8);
        title("Evolução do indicador ∆");
        xlabel("Amostra");
        ylabel("∆");
        hold on
        figure(3)
        plot(hipervolume,'-x','MarkerSize',8);
        title("Evolução do indicador hipervolume");
        xlabel("Amostra");
        ylabel("Hipervolume");
        hold on
        indexIndicadores = indexIndicadores + 1;
    end    

    plotar_fronteira(fronteiraOtima,geracao,Parametros); 
       
    geracao = geracao + 1;

end


% %Mostrar média dos indicadores
deltaMedio = sum(delta)/length(delta);
hipervolumeMedio = sum(hipervolume)/length(hipervolume);

disp("Valor ∆ médio: " + deltaMedio);
disp("Valor hipervolume médio: " + hipervolumeMedio);

% %Calcular dificuldade
for i = 1:numel(fronteiraOtima)
    fronteiraOtima(i).dificuldade = calcular_dificuldade(fronteiraOtima(i),Parametros,Datasets);
end

% %Vetor de pesos 
w = [0.7306 0.0810 0.1884];
% 
% %Aplicar tomadores de decisão
[Q] = promethee(fronteiraOtima,w);

% %Pegar o index do elemento com maior fluxo
[~,index] = max(Q);
% 
% %Melhor resultado dentro da fronteira Pareto estimada
disp("Melhor  solução encontrada: "); 
disp(fronteiraOtima(index).fitness);
disp(fronteiraOtima(index).dificuldade);

hold off

toc