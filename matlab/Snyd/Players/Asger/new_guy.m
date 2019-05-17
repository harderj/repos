function v=new_guy(me,guess,gamestate,roll);
%er jeg den første der gætter?
if guess(1)==0
    v=low_first_guess(roll);
elseif checkStair(roll)==1
    v=igotstairs_guy(me,guess,gamestate,roll);
else
    %Nej der er jeg ikke. Hvad vil jeg så prøve:
    v1=whatigot_guy(me,guess,gamestate,roll);
    v2=whathehas_guy(me,guess,gamestate,roll);
    %Hvilket valg tager jeg.
    if v1(1)>0
        v=v1;
    elseif v2>0
        v=v2;
    else
        v=[0 1];
    end
end
end
    
