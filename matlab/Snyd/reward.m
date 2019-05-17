function out = reward(M,mode)

[NOG, NOP] = size(M);

if strcmp(mode,'Asgers method')
    out = zeros(1,NOP);
    for i=1:NOG
        out = out + winners_of_the_game(M(i,:));
    end
elseif strcmp(mode,'Jacobs method')
    out = -sum(M);
    out = out-min(out);
    out = 100*out/sum(out);
elseif strcmp(mode,'Asgers method norm')
    out = zeros(1,NOP);
    for i=1:NOG
        out = out + winners_of_the_game(M(i,:));
    end
    out = 100*out/sum(out);
elseif strcmp(mode,'One loser norm')
    out = zeros(1,NOP);
    for i=1:NOG
        out = out + (M(i,:)<1);
    end
    out = 100*out/sum(out);
else
    out = sum(M);
end

end