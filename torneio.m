function [campeoes] = torneio(populacao)
    
    tamanhoPopulacao = numel(populacao);
    
    for k = 1:tamanhoPopulacao
    
        %Seleciona n indivíduos para o torneio 
        aleatorio = randperm(tamanhoPopulacao,2);
        aleatorioCrescente = sort(aleatorio);
        
        %Seleciona o de menor índice (mais apto)
        campeoes(k) = populacao(aleatorioCrescente(1));
    end
end

