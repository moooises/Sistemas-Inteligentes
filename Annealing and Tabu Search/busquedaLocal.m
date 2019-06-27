function [x,C]=busquedaLocal(M)

n=1;
actual=[1 2 3 4];
costes = zeros(4,1)';
while n<=4
    varactual = mod(n,4)+1;
    S=Sucesores(actual,varactual);
    
    for i=1:length(S)
        costes(i)=fCoste(S(i,:),M);
        
    end
    cosf=min(costes);
    f=find(costes(:)==cosf);
    
    if fCoste(actual,M)>cosf
        
        actual=S(f,:);
    end
    n=n+1;
end
x=actual;
C=fCoste(x,M);

end

function c=fCoste(x,M)

c= trace(M(1:length(M),x));


end

function x = Sucesores(l,i)

x=zeros(length(l));
for j=1:+1:length(l)
    x1 = l;
    c1=l(i);
    c2=l(j);
    x1(i)=c2;
    x1(j)=c1;
    x(j,:)=x1;
    
end
end