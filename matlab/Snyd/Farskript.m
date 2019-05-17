n=500;
vn=[1:n];
v2n=2.*vn;
vn1=vn.^2-1;
vn2=vn.^2+1;
prim=primes(n*n+1);

%for i=1:n
%    fprintf('%d',v2n(i)); fprintf('%10d',vn1(i)); fprintf('%10d',vn2(i));
%    fprintf('\n');
%end

Vmat=[v2n', vn1', vn2'];
Vmat2=[];
iter=1;

for i = 1:n
    if isempty(find(prim==vn1(i)))==0 && isempty(find(prim==vn2(i)))==0
        Vmat2(iter,:)=Vmat(i,:);
        iter=iter+1;
    end
end
disp(Vmat2);
    

