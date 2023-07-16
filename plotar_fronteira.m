function plotar_fronteira(fronteiraOtima,geracao,Parametros)

    tempoFronteira = [];
    distanciaFronteira = [];
    for i = 1:numel(fronteiraOtima)
        tempoFronteira(i) = fronteiraOtima(i).fitness(1);
        distanciaFronteira(i) = fronteiraOtima(i).fitness(2);
    end
    
    %Intercalar cor entre o vermelho e o azul para o desenho da fronteira
    %não-dominada
    
    if mod (geracao,Parametros.quantidadeGeracoes) == 0
        cor = 'b*';
    elseif mod (geracao,2) == 0
        cor = 'r*';
    else
        cor = 'k*';
    end
    
    figure(2)
    plot(tempoFronteira,distanciaFronteira,cor,'MarkerSize',8);
    title("Fronteira não-dominada")
    xlabel("f1 (tempo)");
    ylabel("f2 (distância)");
    grid on;
    hold on;
end

