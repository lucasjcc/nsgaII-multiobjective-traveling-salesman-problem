function aptidao = fitness(individuo,Parametros,Datasets)
    
    distanciaTotal = 0;
    tempoTotal = 0;
    for i = 1:(Parametros.numeroCidades)
        j = i + 1;
        pos_i = individuo.representacao(i);
        pos_j = individuo.representacao(j);
        tempoTotal = tempoTotal + Datasets.tempo(pos_i,pos_j);
        distanciaTotal = distanciaTotal + Datasets.distancia(pos_i,pos_j);
    end
    aptidao(1) = tempoTotal; 
    aptidao(2) = distanciaTotal; 
end

