function winners=tournmament(Poblacion,n,m)%Poblacion,cuantas parejas y el numero de participantes por torneo
    selec=[];
    ronda=[];
    coste=[];
    for i=1:n*2
        for j=1:m
            s=randi(size(Poblacion,1));
            while s==selec | s==ronda %%para controlar los repetidos
                        s=randi(size(Poblacion,1));
            end
            ronda(j)=s;
            coste(j)=feval(Poblacion(s,:));
        end
        selec(i)=ronda(find(coste==max(coste)));%% es el mejor coste, en este caso es el max pero puede ser el minimo en algunas ocasiones
        winners(i,:)=Poblacion(selec(i),:);
        ronda=[];
    end

end