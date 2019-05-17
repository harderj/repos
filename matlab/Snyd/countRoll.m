function vec = countRoll(roll)
    vec = zeros(1,6);
    m = length(roll);
    for j = 1:m
        d = roll(j);
        vec(d) = vec(d) + 1;
    end
    % check for stair
    if m<7 & (sum(vec(1:min([6,m]))==ones(1,min([6,m])))==m)&m>0
        vec(2:6) = m+1;
    else % else, add count of ones to all
        t = vec(1);
        vec = vec + t;
        vec(1) = vec(1) - t;
    end
end