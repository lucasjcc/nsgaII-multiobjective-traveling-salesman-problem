function [delta] = indicador_delta(A,Pontos)
    N = numel(A);
    if N ~= 1  
        aTempo = [];
        aDistancia = [];
        A_aux = A;

        for i = 1:N
            aTempo(i) = A(i).fitness(1);
            aDistancia(i) = A(i).fitness(2);
        end


        % Classificação baseado em f1
        [~, f1Crescente] = sort(aTempo);
        A = A_aux(f1Crescente);


        d1e = 0;
        d2e = 0;
        di = 0;
        for i = 1:N
            if i == 1
                d1e = d1e + sum(sqrt((A(i).fitness-Pontos.extremoSuperior).^2));
                di = di + sum(sqrt((A(i).fitness-A(i+1).fitness).^2));
            elseif i == N
                d2e = d2e + sum(sqrt((A(i).fitness-Pontos.extremoInferior).^2));
                di = di + sum(sqrt((A(i).fitness-A(i-1).fitness).^2));
            else
                distancia(1) = sum(sqrt((A(i).fitness-A(i-1).fitness).^2));
                distancia(2) = sum(sqrt((A(i).fitness-A(i+1).fitness).^2));
                di = di + min(distancia);
            end
        end

        media = di/N;

        delta = (d1e+d2e+abs(di-media))/(d1e+d2e+N*media);
        
    else
        delta = 1;
    end
           
end

