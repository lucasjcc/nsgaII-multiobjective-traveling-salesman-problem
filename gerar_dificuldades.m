dificuldade = zeros(250,250);

for i = 1:250
    for j = 1:250
        if i == j
            dificuldade(i,j) = 0;
        else
            dificuldade(i,j) = randi(10);
        end
    end
end

save dificuldade.mat dificuldade
