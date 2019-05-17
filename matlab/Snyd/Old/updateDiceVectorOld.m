%This scripts rewards the winners.
%Debugging:
%fprintf('før var dicevectoren:\n');
%disp(diceVector);

diceVector = diceVector - 1;
diceVector(loser) = diceVector(loser) + 1

% if winner==0
%     diceVector=diceVector-1;
%     diceVector(turn)= diceVector(turn)+1;
% else
%     diceVector=diceVector-1;
%     diceVector(mod(turn-2,NOP)+1)= diceVector(mod(turn-2,NOP)+1)+1; 
% end
%Debugging
