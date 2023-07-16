function [Q] = promethee(fronteira,w)
    
    n = numel(fronteira);
    m = 3;
    
    tempo = zeros(n,1);
    distancia = zeros(n,1);
    dificuldade = zeros(n,1);

    for i=1:n
        tempo(i) = fronteira(i).fitness(1);
        distancia(i) = fronteira(i).fitness(2);
        dificuldade(i) = fronteira(i).dificuldade;
    end
    
    D = [tempo distancia dificuldade];
     
    V1=zeros(m,n,n); 
    V=zeros(n,n); 
    Fplus=zeros(n,1);  
    Fminus=zeros(1,n);
    
    for j=1:m
        for i=1:n
            for s=1:n 
                d=D(i,j)-D(s,j);    
                H=0;        
                if d>0              
                    H=1;
                end      
                V1(j,i,s)=w(j)*H;
            end
        end
    end
    
    V(:,:)=sum(V1,1);       

    Fplus =sum(V,2)-diag(V);
    Fminus=sum(V,1)-diag(V)';
    
    Q=Fplus-Fminus';

end

