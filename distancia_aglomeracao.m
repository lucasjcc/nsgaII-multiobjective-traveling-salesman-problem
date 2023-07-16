function populacao = distancia_aglomeracao_2(populacao,fronteira)

    quantidadeFronteiras = numel(fronteira);
    
    %Cálculo para cada fronteira
    for k=1:quantidadeFronteiras 
        nIndividuosFronteira = length(fronteira{k});
        if nIndividuosFronteira == 1            
            populacao(fronteira{k}).crowdingDistance = inf;
            continue;
        elseif nIndividuosFronteira == 2
            populacao(fronteira{k}(1)).crowdingDistance = inf;
            populacao(fronteira{k}(2)).crowdingDistance = inf;
            continue;
        else            
            individuosFronteira = populacao(fronteira{k});
            fitness = [];
            for i = 1:nIndividuosFronteira
                fitness(i) = individuosFronteira(i).fitness(1);
            end  

            %Ordenamento por fitness
            [~,index] = sort(fitness);
            individuosFronteira = individuosFronteira(index);
            
            for j = 1:nIndividuosFronteira
                if j == 1 || j == nIndividuosFronteira
                    d(j) = inf;
                else
                    soma = 0;
                    for i = 1:2
                        numerador = abs(individuosFronteira(j+1).fitness(i)+individuosFronteira(j-1).fitness(i));
                        denominador = abs(individuosFronteira(1).fitness(i)+individuosFronteira(nIndividuosFronteira).fitness(i));
                        soma = soma + numerador/denominador;
                    end
                    d(j) = soma;
                end
                populacao(fronteira{k}(index(j))).crowdingDistance = d(j);
            end
        end   
    end
end
