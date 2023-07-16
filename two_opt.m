%--------------------------------------------------------------------------
function [p,L] = Opt2(p,D,T)
%EXCHANGE2 Improve tour p by 2-opt heuristics (pairwise exchange of edges).
%   The basic operation is to exchange the edge pair (ab,cd) with the pair
%   (ac,bd). The algoritm examines all possible edge pairs in the tour and
%   applies the best exchange. This procedure continues as long as the
%   tour length decreases. The resulting tour is called 2-optimal.

n = numel(p);
zmin = -1;

% Iterate until the tour is 2-optimal
% while (zmin < 0 && epoch<max_ep)
while (zmin < 0)
    
    zmin = 0;
    i = 0;
    b = p(n);
    if(rand<0.5)       
            if(rand<0.5) Data=D;
            else Data=T;
            end           
    else
       Data=D+T;             
    end
    
    
    rangeData = max(Data(:)) - min(Data(:));
    Data = (Data - min(Data(:))) / rangeData;
       
        
        % Loop over all edge pairs (ab,cd)
        while i < n-2
        a = b;
        i = i+1;
        b = p(i);
        Dab = Data(a,b);
        j = i+1;
        d = p(j);
        while j < n
            c = d;
            j = j+1;
            d = p(j);
            % Tour length diff z
            % Note: a == d will occur and give z = 0
            z = (Data(a,c) - Data(c,d)) + Data(b,d) - Dab;
            % Keep best exchange
            if z < zmin
                zmin = z;
                imin = i;
                jmin = j;
            end
        end
        end
        
        % Apply exchange
        if zmin < 0
            p(imin:jmin-1) = p(jmin-1:-1:imin);
        end
        
end
    L=0;
    for i = 1:(numel(p)-1)
        j = i + 1;
        pos_i = p(i);
        pos_j = p(j);
        L = L + Data(pos_i,pos_j);
    end
end
%L=Tour_Cost(p,D);