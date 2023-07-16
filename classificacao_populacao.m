function [populacao, fronteira]=classificacao_populacao(populacao)

    % Classificação baseada na crowding distance
    [~, cdDescendente] = sort([populacao.crowdingDistance],'descend');
    populacao = populacao(cdDescendente);
    
    % Classificação baseada em rank
    [~, rankAscendente]=sort([populacao.rank]);
    populacao=populacao(rankAscendente);
    
    % Atualizar fronteiras
    ranks = [populacao.rank];
    maxRank = max(ranks);
    fronteira = cell(maxRank,1);
    
    for k=1:maxRank
        fronteira{k} = find(ranks==k);
    end

end

