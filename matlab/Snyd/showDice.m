% get winner
num = state(1);
face = state(2);
C = countDice(dice);
if(C(face) < num)
    prevPlayer = mod(turn-2,NAP)+1;
    loser = playing{prevPlayer};
else
    loser = playing{turn};
end

if printLog
    fprintf('There was %d dice of %d, so ',C(face),face);
    fprintf('(%d) %s loses.\n',loser,players{loser}); 
end

diceVector = diceVector - 1;
diceVector(loser) = diceVector(loser) + 1;

% fprintf('Players now has:\n');
% if printLog
%     for i=1:NOP
%         fprintf('(%d) %s: %d dice\n', i, players{i},diceVector(i));
%     end
% end