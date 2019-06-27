function [h1,h2]=PMX(padre1,padre2)%%%dos vectores PADRE
    p1=randi(size(padre1,2));
    p2=randi(size(padre2,2));%%estas posiciones van incluidas en el intervalo
    
    while p2==p1 
         p2=randi(size(padre2,2));
    end
    
    if p2<p1
        aux=p1;
        p1=p2;
        p2=aux;
    end
    intercambio(1,1:(p2-p1)+1)=padre2(p1:p2);
    intercambio(2,1:(p2-p1)+1)=padre1(p1:p2);
    h1(p1:p2)=padre2(p1:p2);
    h2(p1:p2)=padre1(p1:p2);
    h1(p2+1:length(padre2))=0;
    h2(p2+1:length(padre2))=0;

    for i=1:size(padre1,2)%%% puede mejorarse, metes todos los valores en los hijos sin importar si estan repetidos y despues cambias los repetidos con find
       
       if ~isempty(find(padre1(i)==intercambio(2,:)))
        h1(i)=intercambio(1,find(intercambio(2,:)==padre1(i)));  
       else
        h1(i)=padre1(i);
       end
       
          if ~isempty(find(padre2(i)==intercambio(1,:)))
        h2(i)=intercambio(2,find(intercambio(1,:)==padre2(i)))   
       else
        h2(i)=padre2(i);
          end

               
       if i==p1-1
         i=p2+1;
       end
       
    end


end