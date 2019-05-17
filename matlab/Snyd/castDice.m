function cast=castDice(diceVec)
n=length(diceVec);
cast=cell(n,1);
for i=1:n
    cast{i}=throw(diceVec(i));
end
end