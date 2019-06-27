function Selec=roulette(Poblacion,n) %%% matriz de poblacion y el numero de pares que se quiere
    for i=1:size(Poblacion,1)
        Val(i)=feval(Poblacion(i,:)); %% feval depende de cada problema
    end
    
        r=Val/sum(Val);
        Acum=cumsum(r);
        
    for i=1:n*2%%% devolvemos una matriz con n parejas, cada fila una pareja
       p=rand();
       p=find(Acum<=p);
       if(p(end)~=repes)
           Selec(i,:)=Poblacion(p(length(p)));
           repes(i)=p(end);
       else
           i=i-1;%repetimos
       end;
    end

end