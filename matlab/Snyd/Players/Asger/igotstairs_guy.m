function v=igotstairs_guy(me,guess,gamestate,roll)
wig=length(roll)+1;
all=wig+round((1/3*(sum(gamestate)-gamestate(me))));
if all>=guess(1)
    if guess(2)==6&&all>guess(1)
        v=[guess(1)+1 6];
    else
        v=[guess(1) 6];
    end
else
    v=[0 1];
end
end
        
        
        