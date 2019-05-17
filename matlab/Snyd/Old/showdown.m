function winner = showdown(x,y)
%Checker hvem der har vundet
%fprintf('Der blev åbnet på %d %d''ere\n',x(1),x(2))
%Antallet af den valgte værdi tælles op
count = 0;
for i = 1:length(y)
    %fprintf('Slag %d:',i)
    if checkStair(y{i})==1
        count = count + length(y{i}) + 1;
    elseif x(2)==1
        count = count + sum(y{i}==x(2));
    else
        count = count + sum(y{i}==x(2)) + sum(y{i}==1);
    end
    %fprintf('var der %d\n',count)
end
%fprintf('Der var %d %d''ere\n',count,x(2))
if count>=x(1)
    winner = logical(0);
    %disp('Ham der åbnede tabte')
else
    winner = logical(1);
    %disp('Ham der åbnede vandt')
end
end