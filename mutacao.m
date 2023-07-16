%Implementação do Reverse Sequence Mutation (RSM)
%https://arxiv.org/ftp/arxiv/papers/1203/1203.3099.pdf

function [filhos] = mutacao(filhos,Parametros)
    
    tamanhoPopulacao = numel(filhos);
    N = size(filhos(1).representacao, 2);
    
    for k = 1:tamanhoPopulacao
        aleatorio = rand;
        if aleatorio <= Parametros.probabilidadeMutacao
            %Número aleatório de 3 à 249
            pos = 3 + randperm(N-5, 2);
            pos = sort(pos);

            %Split cromossomo dos pais
            pedaco1 = filhos(k).representacao(2:pos(1)-1);
            pedaco2 = filhos(k).representacao(pos(1):pos(2));
            pedaco3 = filhos(k).representacao(pos(2)+1:N-1);
            
            %Inverter a ordem do cromossomo entre os valores de pos
            pedaco2 = flip(pedaco2);
            
            cromossomo = [pedaco1 pedaco2 pedaco3];

            filhos(k).representacao(1,2:N-1) = cromossomo(1,:);
        end
        clear pedaco1 pedaco2 pedaco3 cromossomo
    end
end

