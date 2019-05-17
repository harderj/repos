function v=whatigot_guy(me,guess,gamestate,roll);
v=[0 0];
%Analyse af slag
ran=analysis(roll);
%Antal terninger i alt
sumdice=sum(gamestate);
%Antal spillere i alt
%sumplayers=length(gamestate); %Hvis spillere forsvinder fra gamestate
sumplayers=number_of_players(gamestate);
%jeg kigger fra toppen af om jeg kan toppe den.
iter=0;
while (1)
iter=iter+1;
if iter>5
    break
end
of=7-iter;
igot=ran(of);
%Med ettere:
igot=igot+ran(1);
%Hvad er der nok ialt:
all=igot+round(1/3*(sumdice-gamestate(me)));
if all>=guess(1)
    if of>guess(2)
        v=[guess(1) of];
        break
    elseif all>guess(1)
        v=[guess(1)+1 of];
        break
    else
        v=[0 1];
    end
end
end
end
        
       
        

