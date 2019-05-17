function vec = countDice(dice)
vec = zeros(1,6);

% count dices
n = length(dice);
for i = 1:n
    vec = vec + countRoll(dice{i});
end

end