function out = validCall(x,y)
%Undersøger om det nye gæt er højere end det forrige
out=0;
%disp('Der tjekkes om det er et gyldigt kald')
if x(1)<y(1)
    out = logical(0);
elseif x(1)==y(1)
    if x(2)>y(2)
        out = logical(1);
    end
else
    out = logical(1);
end