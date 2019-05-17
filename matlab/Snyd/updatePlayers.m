playing={};
j=1;
for i=1:NOP
    if diceVector(i)>0
        playing{j}=i;
        j=j+1;
    else
        dices{i}=[];
    end
        
end
NAP = length(playing);