
function annealing()
N=4;%6,8,10,...
Tiempo=[12,43,15,7;9,10,6,4;5,13,29,2;4,11,17,9];%magic(4)

rand('seed',1);
Actual=randperm(N);
T=1000;
T_Min=0.001;
Iter=1;

while(T>T_Min | Iter~=1000)
TG(Iter)=T;
Nuevo=randperm(N);%sucesor, en este caso es un randperm pero podria se de cualquier forma 
Delta=fval(Nuevo,Tiempo)-fval(Actual,Tiempo);
    if Delta<0
       Actual=Nuevo;
    else
        p=exp(-Delta/T);
        if p>rand
            Actual=Nuevo;
        end
    end
    T=enfriar(T);
    Iter=Iter+1;
end
Actual
Iter
plot(TG);
end

function f=fval(Estado,Tiempo)
f=0;
length(Estado)
for t=1:length(Estado)
   f=Tiempo(t,Estado(t))+f ;
end
end


function e=enfriar(T)

%e=T/(i+1); %%cauchy
e=0.77*T; %% exponencial 0.77 valor optimo
end