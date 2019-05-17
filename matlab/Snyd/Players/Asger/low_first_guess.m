function v=low_first_guess(roll)
%Analyse af slag
ran=analysis(roll);
[maxi index]=max(ran(2:6));
v=[1 index+1];
end