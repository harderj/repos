function count=number_of_players(gamestate);
count=0;
for i = 1:length(gamestate)
    if gamestate(i)>0
        count=count+1;
    end
end
end