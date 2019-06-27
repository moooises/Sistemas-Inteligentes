%%%%dominios=ones(N,3); % 1 Rojo 2 Verde 3 Azul para cada variable
%%% N=7;
%%
function valores=orden_valores_dominio(vari, caso,dominios,G)
%%%function orden_valores_dominio(vari,…)
%%% devuelve la lista de valores ordenados según caso
valores=0;
posibles=find(G(vari,1:3)==1) %% indices posibles
if length(posibles)>0
switch(caso)
case 1,%%% Asigna el siguiente valor no asignado
valores=posibles;

case 2,%%% Valor menos restringido, el que aparece en el dominio de menos variables

aux=find(dominios(vari,1:3)==1)%necesito saber que colores tiene el dominio
if length(aux)==0
    valores=0;
else 
    for j=1:length(aux)
        VMR(1,j)=length(find(dominios(posibles,aux(j))==1))
        VMR(2,j)=aux(j)
    end
    ord=sort(VMR(1,:))
    %%de aqui para abajo sobra, devuelve el que menos se repita en VMR y
    %%ya, lo de abajo ordena de menor a mayor
    j=1;
    while j<=length(aux)
        pos=find(VMR(1,:)==ord(j));
        if length(pos)==1
       valores(j)=pos;
       j=j+1;
        else
        valores(j:length(pos))=pos;
        j=j+length(pos);
        end
    end
end

otherwise,
valores=0;
end
end
end