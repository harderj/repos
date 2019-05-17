
IDV = ones(1,NOP)*6;
;          % initial dice vector
diceVector = IDV;
dice = castDice(IDV);
updatePlayers;
loser = randi([1, NOP]);
results = zeros(1, NOP);

if printLog
    format compact;
    fprintf('Number of players: %d\n',NOP);
end

cm = 1000; % max number of rounds
cs = 1; % prevent crashes
while NAP>1 && cs<cm
    if printLog
        fprintf('------Heat #%2.d------\n',cs);
        for i=1:NOP
            if diceVector(i)>0
                fprintf('(%d) %s rolls:\n',i,players{i});
                disp(dice{i})
            end
        end
    end
    heat
    updatePlayers
    cs=cs+1;
end