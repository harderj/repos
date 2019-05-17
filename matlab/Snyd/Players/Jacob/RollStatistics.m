N = 10000; % finetuning of probability

r = nan(6,6);
for i=1:6
    c = nan(N, 6);
    for j=1:N
        c(j,:) = countRoll(throw(i));
    end
    r(i,:) = sum(c)/(N*i);
end

R = sum(transpose(r(:,2:6)))/5;

disp(R);
close all;
clf;
hold all;
plot(R);
