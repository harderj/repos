function results=winners_of_the_game(vec);
%Denne funktion giver points:
NOP = length(vec);
results=zeros(1,NOP);
newvec=vec;
before=-1;
beforenumb=0;
for i=1:NOP
    [value, number]=max(newvec);
    if before==value
    results(number)=beforenumb;
    else
    results(number)=i-1;
    beforenumb=i-1;
    end
    before=value;
    %Lavt tal:
    newvec(number)=-20000;
end
end
    
    