function Actual=SimulatedAnneling(M)

    T=30;
    T_min=10;
    X=[];
    TV=[];
    Actual=randperm(4);
    n=1;

    while T>T_min
        Nuevo=sucesoraleatorio(Actual, n);% seleccionamos un sucesor aleatorio
        deltaE=fCoste(Nuevo,M)-fCoste(Actual,M);
        if(deltaE<0)% si la resta da 0 es la mejor solucion
            Actual=Nuevo;
        else%si no
            p=exp(-deltaE/T);%calculamos el exponencial de deltaE/T
            if p>rand(0,1)% decidimos aleatoriamente si es mejor
                Actual=Nuevo;%si lo es se asigna el nuevo estado
            end
        end
    X(n)=n;
    TV(n)=T;
    T=0.8*T;%enfriamos la T
    n=n+1;
    end
plot(X,TV)
end

function S=sucesoraleatorio(actual,n)
S=Sucesores(actual,mod(n,4)+1);
S=S(randi(4),:);


end

function c=fCoste(x,M)
c=trace(M(:,x));

end

function x = Sucesores(l,i)

x=zeros(length(l));
x1 = l;
for j=1:+1:length(l)
    x1 = l;
    c1=l(i);
    c2=l(j);
    x1(i)=c2;
    x1(j)=c1;
    x(j,:)=x1;
    
end
end