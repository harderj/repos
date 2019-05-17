function [v sumdice]=whathehas_guy(me,guess,gamestate,roll);
v=[0 0];
%Analyse af slag
ran=analysis(roll);
%Antal terninger i alt
sumdice=sum(gamestate);
%Antal spillere i alt
%sumplayers=length(gamestate); %Hvis spillere forsvinder fra gamestate
sumplayers=number_of_players(gamestate);
%hvem fik jeg den af
indexbefore=player_before_me(gamestate,me);
%hvor mange terninger havde han?
hehad=gamestate(indexbefore);
%Hvad der er af det han sagde:
hmm=ran(1)+ran(guess(2));
%Tror jeg på ham?
if hmm+ceil(1/3*(sumdice-gamestate(me)))>guess(1)
    v=[guess(1)+1, guess(2)];
else
    v=[0 1];
end
end
    
    



