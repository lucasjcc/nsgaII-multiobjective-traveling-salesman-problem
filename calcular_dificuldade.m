function dificuldade = calcular_dificuldade(individuo,Parametros,Datasets)
    
    dificuldadeTotal = 0;
    for i = 1:(Parametros.numeroCidades)
        j = i + 1;
        pos_i = individuo.representacao(i);
        pos_j = individuo.representacao(j);
        dificuldadeTotal = dificuldadeTotal + Datasets.dificuldade(pos_i,pos_j);
    end
    dificuldade = dificuldadeTotal/Parametros.numeroCidades; 
end

