function [populacao,fronteira] = classificacao_dominancia(populacao)
        
    tamanhoPopulacao = numel(populacao);
    
    for i=1:tamanhoPopulacao
        populacao(i).conjuntoDominante=[];
        populacao(i).contadorDominado=0;
    end
    
    fronteira{1}=[];
    
    for i=1:tamanhoPopulacao
        for j=i+1:tamanhoPopulacao
            p = populacao(i);
            q = populacao(j);
            
            if  all(p.fitness <= q.fitness) && any(p.fitness < q.fitness)
                p.conjuntoDominante = [p.conjuntoDominante j];
                q.contadorDominado = q.contadorDominado + 1;
            end
            
            if  all(q.fitness <= p.fitness) && any(q.fitness < p.fitness)
                q.conjuntoDominante = [q.conjuntoDominante i];
                p.contadorDominado = p.contadorDominado + 1;
            end
            
            populacao(i) = p;
            populacao(j) = q;
        end
        
        if populacao(i).contadorDominado == 0
            fronteira{1}=[fronteira{1} i];
            populacao(i).rank = 1;
        end
    end
    
    k=1;
    
    while true
        
        Q = [];
        
        for i = fronteira{k}
            p = populacao(i);
            
            for j = p.conjuntoDominante
                q = populacao(j);
                
                q.contadorDominado = q.contadorDominado - 1;
                
                if q.contadorDominado == 0
                    Q = [Q j];
                    q.rank = k+1;
                end
                
                populacao(j) = q;
            end
        end
        
        if isempty(Q)
            break;
        end
        
        fronteira{k+1} = Q;
        
        k=k+1;  
        
    end
end

