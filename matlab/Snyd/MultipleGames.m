% run multiple games

%% Settings:
NOG = 1000; % number of games
playerNames = {'new_guy','Conservative'};
scrambleOrder = true; % change places each new game?
format compact;

%% Procedure:

% make sure playerscripts are accessible
setup;

% NOP for 'Number Of Players' are defined
NOP=length(playerNames);

% score of each game for each player is saved in a matrix
endDice=zeros(NOG,NOP);

% logging of every action in each game is disabled
printLog = false;

for GN=1:NOG % GN for 'Game number'
    order = 1:NOP;
    iorder = order;
    if scrambleOrder
        order = randperm(NOP);
        iorder = iord(order);
    end
    players = {playerNames{order}};
    game
    endDice(GN,:) = diceVector(iorder);
    fprintf('Game #%4.d:',GN)
    disp(diceVector);
end

highscore = reward(endDice,'One loser norm');
disp('Final scores is:')
for GN=1:NOP
    fprintf('(%d) %s: %.1f\n',GN,playerNames{GN},highscore(GN));
end