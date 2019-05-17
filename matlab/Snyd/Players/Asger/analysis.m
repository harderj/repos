function an=analysis(roll)
%Analysere terninge kastet
%Returnere en vektor med antallet af 1'ere 2'ere osv.
%an=[antal 1, antal 2,antal 3, antal 4, antal 5, antal 6]

n=length(roll);
an=zeros(1,6);
for i = 1:n
    eyes=roll(i);
    an(eyes)=an(eyes)+1;
end
end