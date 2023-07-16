function [filhos] = crossover(pais,Parametros)

    quantidadePais = numel(pais);
    indexPais = 1;
    
    %Quantidade de cromossomos
    N = size(pais(1).representacao, 2);
        
    for i = 1:quantidadePais
        filhos(i) = Individuo(Parametros.numeroCidades);
    end
    
    for k = 1:(quantidadePais/2)
        representacao = zeros(2, N-2);
        
        %Número aleatório de 3 à 249
        pos = 3 + randperm(N-5, 2);
        pos = sort(pos);
        
        %Split cromossomo dos pais
        pedaco1_pai1 = pais(indexPais).representacao(2:pos(1)-1);
        pedaco2_pai1 = pais(indexPais).representacao(pos(1):pos(2));
        pedaco3_pai1 = pais(indexPais).representacao(pos(2)+1:N-1);

        pedaco1_pai2 = pais(indexPais+1).representacao(2:pos(1)-1);
        pedaco2_pai2 = pais(indexPais+1).representacao(pos(1):pos(2));
        pedaco3_pai2 = pais(indexPais+1).representacao(pos(2)+1:N-1);
        
        %Montagem do cromossomo dos filhos
        representacao(1,pos(1)-1:pos(2)-1) = pedaco2_pai1;
        representacao(2,pos(1)-1:pos(2)-1) = pedaco2_pai2;
        
        %Excluir valores que já estão no cromossomo dos filhos
        reorganizar = zeros(2, N-2);
        reorganizar(1,:) = [pedaco3_pai2 pedaco1_pai2 pedaco2_pai2];
        reorganizar(2,:) = [pedaco3_pai1 pedaco1_pai1 pedaco2_pai1];
        
        diferenca(1,:) = setdiff(reorganizar(1,:),pedaco2_pai1,'stable');
        diferenca(2,:) = setdiff(reorganizar(2,:),pedaco2_pai2,'stable');
        
        i = pos(2);
        j = 1;
        while any(representacao(2,:) == 0)
            if i == N-1
                i = 1;
            end
            representacao(1,i) = diferenca(1,j);
            representacao(2,i) = diferenca(2,j);
            i = i + 1;
            j = j + 1;
        end    
        
        filhos(indexPais).representacao(1,2:N-1) = representacao(1,:);
        filhos(indexPais+1).representacao(1,2:N-1) = representacao(2,:);

        indexPais = indexPais + 2;  
        
        clear pedaco1_pai1 pedaco2_pai1 pedaco3_pai1 pedaco1_pai2 pedaco2_pai2 pedaco3_pai2
        clear diferenca
    end
       
end

