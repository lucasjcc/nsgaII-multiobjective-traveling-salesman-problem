function [hipervolume] = indicador_hipervolume(fronteira,Pontos)
   
    
    %Excluir elementos repetidos da fronteira
    copiaFronteira = fronteira;
    index = 1;
    indexElementosRepetidos = [];
    for i = 1:numel(copiaFronteira)
        for j = i+1:numel(copiaFronteira)
            if isequal(copiaFronteira(i).fitness,copiaFronteira(j).fitness)
                indexElementosRepetidos(1,index) = j;
                index = index + 1;
            end
        end
    end
    
    copiaFronteira(indexElementosRepetidos) = [];
        
    vetorReferencia = 1.1*Pontos.antiutopico;
    hipervolume = 0;
    N = numel(copiaFronteira);
    
    if N ~= 1  
        fronteiraTempo = [];
        fronteiraDistancia = [];

        for i = 1:N
            fronteiraTempo(i) = copiaFronteira(i).fitness(1);
            fronteiraDistancia(i) = copiaFronteira(i).fitness(2);
        end
        
        % Classificação baseado em f1
        [fronteiraTempo, f1Decrescente] = sort(fronteiraTempo,'descend');
        copiaFronteira = copiaFronteira(f1Decrescente);
        
        % Classificação baseado em f1
        fronteiraDistancia = sort(fronteiraDistancia);
        
        %Normalização dos valores
        fronteiraTempo = fronteiraTempo/vetorReferencia(1);
        fronteiraDistancia = fronteiraDistancia/vetorReferencia(2);
        
        %Pontos da fronteira não-dominada que dominam o vetor de referência            
        for i = 1:N-1
          if all(copiaFronteira(i).fitness <= vetorReferencia) && any(copiaFronteira(i).fitness < vetorReferencia) 
              base = abs(fronteiraTempo(i) - vetorReferencia(1));
              altura = abs(fronteiraDistancia(i) - fronteiraDistancia(i+1));
              hipervolume = hipervolume + base*altura;
          end
        end
    end            
end

