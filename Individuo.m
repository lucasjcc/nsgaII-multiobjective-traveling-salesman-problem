classdef Individuo
    
    properties
        representacao;
        fitness;
        rank;
        conjuntoDominante;
        contadorDominado;
        crowdingDistance;
        dificuldade;
    end
    
    methods
        function obj = Individuo(numeroCidades)
            cromossomo = 1+randperm(numeroCidades-1, numeroCidades-1);
            obj.representacao = zeros(1,numeroCidades+1);
            obj.representacao = [1 cromossomo 1];
            obj.fitness = [];
            obj.rank = [];
            obj.conjuntoDominante=[];
            obj.contadorDominado = [];
            obj.crowdingDistance = [];
            obj.dificuldade = [];
        end
    end
end

