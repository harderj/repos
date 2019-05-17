function mine = myAmount(x,myRoll)
%Returns how many i have of that kind
%Format: myAmount(value,myRoll)

if checkStair(myRoll)==1
    mine = length(myRoll) + 1;
elseif x==1
    mine = sum(myRoll==x);
else
    mine = sum(myRoll==x) + sum(myRoll==1);
end
end
