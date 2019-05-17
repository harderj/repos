function out = checkStair(x)
%Tjekker om der er slået en trappe
%disp('Der bliver tjekket for trappen')
n = length(x);
if sum(x) == 1/2*n*(n+1)
    xsort = sort(x);
    tf = zeros(1,n-1);
    for i = 1:(n-1)
        tf(i) = xsort(i)<xsort(i+1);
    end
    if sum(tf)==length(tf)
        out = logical(1);
        %disp('Den var der')
    else
        out = logical(0);
        %disp('Den var der ikke')
    end
else
    out = logical(0);
    %disp('Den var der ikke')
end
end