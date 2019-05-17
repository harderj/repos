function call = Conservative(ID,state,dice,roll)

C=countRoll(roll);
N=sum(nonneg(dice)); % total number of dice in game
n=length(roll); % number of dice in own cup
count = state(1);
face = state(2);
[highValue, highIndex] = max(C);

R = N-n;
r = count-C(face);

magicalNumber = 0.5;

if r/R > magicalNumber
    call = [0, 0];
else
    call = [count+1, highIndex];
end

end