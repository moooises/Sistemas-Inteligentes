function sol= NReinasPSO()

clear all;
close all;
clc;


NReinas=10;
NTableros=15;
MAX_ITERACIONES=2000;
MAXFITNESS=sum(1:NReinas-1);

cp=0.5;    % aceleración hacia la local
cg=0.5;    % aceleración hacia la global
w=0.5;     % influencia de la solución previa
%% 1. Genera poblacion (posiciones) y velocidades
poblacion=generaTableros(NReinas,NTableros)
velocidades= cell(NTableros,1)  %% cada individuo puede tener más o menos velocidades
%% 2. Evaluacion de los tableros
fitness=EvaluaPoblacion(poblacion)%devuelve un vector
%% 3. Calcula pbest y gbest
[val,ind]=max(fitness);
gbest=[poblacion(ind,:),fitness(ind)]
pbest=[poblacion,fitness]
itera=1;
while (itera<=MAX_ITERACIONES) && gbest(end)< MAXFITNESS%% COMPLETAR resto de condiciones
    individuo=1;
    while (individuo<=NTableros)  %%va calculando por cada individuo
        %% 1. Calculo de la velocidad
        %% vels =     wVik     +    cp rp  * Errp + cg rg  *   Errg);
        Vi=velocidades{individuo};

        Vi=multiplicav0(w,velocidades{individuo});
        Errp=sustraeTablerosv0(poblacion(individuo,:),pbest(individuo,1:NReinas));
        Errg=sustraeTablerosv0(poblacion(individuo,:),gbest(1:NReinas));
        %% Calcula cuantos intercambios (velocidades) cogera de cada tipo
        cprp=cp*rand;
        cgrg=cg*rand;
        Vp=multiplicav0(cprp,Errp);
        Vg=multiplicav0(cgrg,Errg);
        %% Suma Velocidades 2 a 2
        Vtotal=sumaVelocidadesv0(Vi,Vp);
        Vtotal=sumaVelocidadesv0(Vtotal,Vg);
        %% Suma Velocidad a la posicion actual
        poblacion(individuo,:)=aplicaVelocidadv0(poblacion(individuo,:),Vtotal);
        
        %% Se guardan los pares de Vtotal en un vector columna        
        velocidades{individuo,:}=zeros(1,size(velocidades,2));
        if ~isempty(Vtotal)
           velocidades{individuo,1}=Vtotal;
        end            
        
        f=EvaluaTablero(poblacion(individuo,:));
        %%% Actualizar mejores fitness
        %% local
        
        if(pbest(individuo,length(pbest(individuo))<f))
            pbest(individuo,1:length(pbest(individuo,:))-1)=poblacion(individuo,:);
            pbest(individuo,length(pbest(individuo,:)))=f;
        end
       
        %% global
        if(gbest(length(gbest))<f)
            gbest(1:length(gbest)-1)=poblacion(individuo,:);
            gbest(length(gbest))=f;
        end
        individuo=individuo+1;
        
    end %% for
    
        itera=itera+1;
end 
velocidades
poblacion
gbest(end,:)
itera


end

function t=aplicaVelocidadv0(S,V)
    if(~isempty(V))
        if(V~=0)
            
            t=intercambio(S,V(1,1),V(1,2));
        else
            t=S;
        end
    else
    t=S;
    end
end


function Vnew=multiplicav0(r,V)
    N=size(V,1);
    Vnew=[];
    
    indices=[];
  
    if N>0
          % generamos aleatorios por cada intercambio en V
          % escogemos los que superen el valor r
       aleatorio=rand(1,N);
      indices=find(aleatorio>r);
      pepe=indices;
        if ~isempty(indices)
            Vnew=V(indices,:);  % elegimos 
        end
    end
end

function V=sumaVelocidadesv0(V1,V2)
    % (1,2) + (2,3) = (1,3)
    l1=size(V1,1);
    l2=size(V2,1); % longitudes de ambas listas
    i=1;
    V=[];
    while ((i<=l1) & (i<=l2))
        if(V1==0)
            V1(1,1)=0;
            V1(1,2)=0;
        end
        if(V2==0)
            V2(1,1)=0;
            V2(1,2)=0;
        end
        if V1(i,2)==V2(i,1)
            V(i,1)=V1(i,1);
             V(i,2)=V2(i,2);
        else
             V(i,:)=V1(i,:);
             %COMPLETAR
        end
        i=i+1;
    end
    % resto de elementos de cada lista se copian tal cual
    if (i<=l1)
        V(i:l1,:)=V1(i:end,:);
    else
        if (i<=l2)
           V(i:l2,:)=V2(i:end,:);
        end
    end

end

function intercambios=sustraeTablerosv0(t2,t1)
    % numero de diferencias existentes entre 2 tableros
    % intercambios guarda la información necesaria para convertir t1 en t2

    N=length(t1);   
    diferencia=(t1==t2);
    i=N;
    k=1;
    intercambios=[];
    taux=t1;
    j=1;  % inicialización para que funcione el código
     pos=find(diferencia==0);
    while sum(diferencia)~=N & i>0
         
         if diferencia(i)==0
          %   pos=find(t2==t1(i)); %%busco la posición de t2 que esté en t1
           %  t2
           %  valor=t1(i)
            % posi=find(t2==t1(i))
            %t1=intercambio(taux,i,pos)
          
          ordenadas=sort(pos);
           num=length(ordenadas);
           cambio1=ordenadas(num);
           cambio2=ordenadas(num-1);
          t1=intercambio(t1,cambio1,cambio2);
            intercambios(k,:)=[cambio1,cambio2];
            diferencia=(t1==t2);
             pos=find(diferencia==0);
           k=k+1;
         end
        i=i-1;
         diferencia=(t1==t2);
    end
   
    %{
    N=length(t1);
    diferencia=(t1==t2);
    i=N;
    k=1;
    intercambios=[];
    taux=t1;
    j=1;  % inicialización para que funcione el código
    
    while sum(diferencia)~=N & i>0
         if ~diferencia(i)
            taux=intercambio(taux,i,j);
            intercambios(k,:)=[i,j];
            
         end
         i=i-1;
    diferencia=(taux==t2);
    end
    t2
    taux
   %}
end
function sol=intercambio(taux,i,j)

sol=taux;
sol(i)=taux(j);
sol(j)=taux(i);

end

function e=EvaluaPoblacion(V)
    for i=1:length(V)
        e(i,:)=EvaluaTablero(V(i,:));
    end
end

function r=EvaluaTablero(V)
    %% debe recorrer el tablero y no encontrar 2 reinas en la misma fila,
    %% columna y diagonal
    %% si el operador aplicado es el intercambio colisiones en filas y columnas
    %% nunca se producirán, por tanto las importantes son en diagonal
    %% Suponiendo que cada Reina ocupa una columna diferente, se suman las
    %% colisiones en diagonal y en fila
    r=0;
    for i=1:length(V)-1
        for j=i+1:length(V)
             r=r+ (abs(V(i)-V(j))==abs(i-j))+(V(i)==V(j));
        end
    end


    %%% Maximización del problema, 

    r=-1*r;  %% Maximiza el problema, pero además en ciertos problemas los valores deben ser positivos, 
                %% por tanto le sumamos el número máximo de ataques posibles,
                %% así 0 conflictos significa la máxima evaluación

    maxAtaques=sum(1:length(V)-1);
    r=maxAtaques+r;
end

function poblacion=generaTableros(NReinas, NTableros)

    for i=1:NTableros
        poblacion(i,:)=randperm(NReinas);
    end
end