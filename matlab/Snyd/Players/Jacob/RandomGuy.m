function call = RandomGuy(ID,state,dice,roll)

N = sum(nonneg(dice));

call = [randi([1, N]), randi([2, 6])];

end