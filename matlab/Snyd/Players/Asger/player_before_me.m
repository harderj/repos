function index=player_before_me(gamestate,me)
in=1;
safety=0;
while (1)
    if me-in>0
    if gamestate(me-in)>0
        index=me-in;
        break
    elseif safety>=length(gamestate)
        index=me-1;
        break
    else
        in=in+1;
        safety=safety+1;
    end
    else
        if gamestate(me-in+length(gamestate))>0
        index=me-in+length(gamestate);
        break
    elseif safety>=length(gamestate)
        index=me-1;
        break
    else
        in=in+1;
        safety=safety+1;
    end
end
end
        