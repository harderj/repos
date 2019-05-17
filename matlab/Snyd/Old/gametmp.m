% game setup

% TODO:
% make sure the loosing player starts next heat
% Muliggøre eliminering af udskrift

%if prompt
%    NOP = input('Number of players: ');
%    players = {};
%    for i=1:NOP
%   end
%end


players={'randomGuy', 'randomGuy','randomGuy'};
NOP=3;
IDV = ones(1,NOP)*6;          % initial dice vector
diceVector = IDV;
dices = castDices(IDV);
updatePlayers;

fprintf('Number of players: %d\n',NOP)

cm = 1000; % max number of rounds
cs = 1; % prevent crashes
while NAP>1 && cs<cm
    fprintf('Heat #%d\n\n',cs);
    for i=1:NOP
        if diceVector(i)>0
        fprintf('Player %d %s:',i,players{i});
        disp(dices{i})
        end
    end
    heat
    updatePlayers
    cs=cs+1;
end
%Vi giver lige nogle points.
results=winners_of_the_game(diceVector,NOP);