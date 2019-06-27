function Tabu_Search()%esta mal%arreglado
rand('seed',2)
    Current=randperm(4)
    Best=Current;
    tabu_list=zeros(4);
    ternure=3;
    c=1;
    c_max=1000;
            [a,b]=size(tabu_list);

    while(c<c_max)
         n=1;
        suc=Sucesores(Current);
        while(~isempty(suc) && n<a+1)%suc esta vacia
            New=suc(n,:);
            if fevalu(New(5:end))<fevalu(Best)
                Current=New(5:end);
                Best=Current;
                tabu_list(New(1),New(2))=ternure;
                suc=[];%vaciamos suc    
            else
                if tabu_list(New(1),New(2))==0;
                    Current=New(5:end);
                    tabu_list(New(1),New(2))=ternure;
                    suc=[];
                  else
                    n=n+1; 
                end
            end
            end
        c=c+1;
        tabu_list = tabu_list-1;
        tabulist(find(tabu_list<0))=0;
        Best;
        Current;
    end
    Best
end


    function  suc= Sucesores(t)
%%% Sucesores devuelve una matriz con los intercambios realizados
%%% t    tablero de N Reinas
%%% suc  lista ordenada de sucesores

suc=[]; %% matriz que almacenar? todos los movimientos posibles para su evaluaci?n
k=1;
eval=fevalu(t);
for i=1:length(t)-1
    for j=i+1:length(t)
        tsucesor=t;
        tsucesor(i)=t(j);
        tsucesor(j)=t(i);
        e=fevalu(tsucesor);
        suc(k,:)=[i,j,e,e-eval,tsucesor];
        k=k+1;
    end
end


suc=sortrows(suc,3);
    end

function r=fevalu(V)
%% debe recorrer el tablero y no encontrar 2 reinas en la misma fila,
%% columna y diagonal
%% si el operador aplicado es el intercambio colisiones en filas y columnas
%% nunca se producir?n, por tanto las importantes son en diagonal
r=0;
for i=1:length(V)-1
    for j=i+1:length(V)
         r=r+ (abs(V(i)-V(j))==abs(i-j));
    end
end
end

function t=intercambio(i,j,t)
aux=t(i);
t(i)=t(j);
t(j)=aux;
end