function [populacaoInicial] = gerar_populacao(Parametros)
    
    numeroCidades = Parametros.numeroCidades;
    tamanhoPopulacao = Parametros.tamanhoPopulacao;
    
    %Geração aleatória através de uma permutação
    for i = 1:tamanhoPopulacao
        populacaoInicial(i) = Individuo(numeroCidades);
    end
end

