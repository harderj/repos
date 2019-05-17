function call = Lurendrejeren(ID,state,dice,roll)

N = sum(dice); % total number of dice
[n k] = state;
face = countRoll(roll); % own rolls distribution of faces

p = 0.39; % probability constant. What is the probability of 


prom = face./N; % prominence of each face
luck = sum(prom);
[high, highIndex] = max(prom);
magicalNumber = 0.39;
luckyNumber = 1.41;



if 
elseif luck>luckyNumber
    call = state + [1 0];
elseif state(1)/N > magicalNumber;
    call = [0 0];
else
    call = [ceil(magicalNumber*N), highIndex];
end

if luck>1.6 && rand < 0.01
    fprintf('Fuck me? Fuck yoouuuu!\n');
end

end