%%
%N=7; %% para indicar el número de regiones
%variables=1:N; %%una variable por región: AO TN AS Q NGS V T
%x=zeros(1,N); %% asignación AO TN AS Q NGS V T
%dominios=ones(N,3); % 1 Rojo 2 Verde 3 Azul para cada variable
%G=[1,1,0,0,1,0,0;1,1,1,0,1,0,0;0,1,1,1,1,0,0;0,0,1,1,1,1,0;1,1,1,1,1,1,0;0,0,0,1,1,1,0;0,0,0,0,0,0,1];


%%
function [vari]=selecciona_var_no_asignada(x, dominios, G, caso)
%% devuelve la siguiente variable no asignada según criterio
noasig=find(x==0);
N=7;
if length(noasig)>0
switch(caso)
case 1,%%% Asigna la siguiente variable no asignada
    if ~isempty(noasig)
       vari=0;
    else
        vari=noasig(1);
    end
    break;
case 2,%%% Grado Heurístico: Asigna variable que participa en más restricciones
    for i=1:N
        GH(i)=length(find(G(i,1:N)==1));
    end
    vari=find(GH==max(GH));%%devuelve la fila que mas resticciones tiene 
    break;
case 3,%%% MVR: Asigna la variable con menos valores restantes
    for i=1:N
    MVR(i)=length(find(dominios(i,1:3)==1));
    end
    vari=find(MVR==min(MVR));
    break;
    
otherwise,
vari=0;
end
end
end