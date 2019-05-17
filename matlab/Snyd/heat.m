firstCall = true;
turn = loser - 1;
state = [0, 6];
call = [0, 6];
NAP = length(playing); % number of active players

while firstCall || validCall(call,state)
    if printLog
        if firstCall==false
            fprintf('(%d) %s thinks there is %d dice of %d.\n',...
                turn,players{pID},call(1),call(2));
        else
            fprintf('(%d) %s to start.\n',...
                turn+1,players{turn+1});
        end
    end
    firstCall = false;
    state = call;
    turn = mod(turn,NAP)+1;
    pID = playing{turn};
    call = callPlayer(players{pID},pID,state,diceVector,dice{pID});
end

if printLog
    fprintf('(%d) %s denies!\n',...
        turn,players{playing{turn}});
end

showDice;

if printLog
    for i=find(diceVector==0)
        fprintf('(%d) %s has won!\n',i,players{i});
    end
end

dice = castDice(diceVector);