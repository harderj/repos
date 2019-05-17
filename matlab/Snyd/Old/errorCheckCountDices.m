% errorCheckCountDices

n = 10; % number of checks

for i = 1:n
    maxP = 5;
    maxD = 6;
    diceV = floor(rand(1,floor(rand(1,1)*maxP)+1)*maxD)+1;
    dices = castDices(diceV);
    count = countDices(dices);
    disp('Count:');
    disp(count);
end