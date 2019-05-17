function call = MrThatGuy(~,state,dice,roll)
%MrThatGuy

n = sum(dice);      %Antal terninger i alt
m = sum(roll);      %Antal terninger jeg har
amount = state(1);  %Antal der er meldt
face = state(2);    %Værdi der er meldt

myDice = countRoll(roll);   %Mine terninger tælles op
noOnes = myDice;
noOnes(1) = [];
few = fewest(myDice);
max = max(noOnes);
    
if amount==0
    call = [m/2 few];

if state(1)>(sum(dice)/3)
    call = [0 0];
else
    call = [state(1)+1 state(2)];
end
end

function few = fewest(x)
%Funktion der bestemmer den værdi jeg har færrest af
min = min(x);
for i = m:-1:1
    if x(i)==min
        few = i;
    end
end


function many = most(x)
%Funktion der bestemmer den værdi jeg har flest af
max = max(x);
for i = 1:m
    if x(i)==max
        many = i;
    end
end