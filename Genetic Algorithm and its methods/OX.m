function [h1,h2]=OX(padre1,padre2)%sin terminar
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
    
    
    h1(p1:p2)=padre1(p1:p2);
    h2(p1:p2)=padre2(p1:p2);
    h1(p2+1:length(padre2))=0;
    h2(p2+1:length(padre2))=0;
    
    %%h1(p2+1:length(padre2))=padre2(p2+1:length(padre2));
    %%h1(1:p1-1)=padre2(1:p1-1)
    %%h2(p2+1:length(padre1))=padre1(p2+1:length(padre1));
    %%h2(1:p1-1)=padre1(1:p1-1)
    %%repes(1,:)=find(h1==padre2);
    %%repes(2,:)=find(h2==padre1)
    
    i=p2+1;
    j=i;
    while i~=length(padre1) | j~=p1
        
        if(j>length(padre1))
               j=1; 
        end
        
        if isempty(find(padre2(j)==h1(p1:p2)))
            h1(i)=padre2(j);
            i=i+1;
            j=j+1;
        else
            j=j+1;
        end
        
    end
       
    i=1;
    
    while j~=p1 | i~=length(padre1)    
        
        if(j>length(padre1))
           j=1; 
        end
        
       if isempty(find(padre2(j)==h1(1:p1-1)))
            h1(i)=padre2(j);
            i=i+1;
            j=j+1;
        else
            j=j+1;
        end
        
    end
    
    i=p2+1;
    j=i;
    while i~=length(padre2) | j~=p1
        
        if(j>length(padre2))
               j=1; 
        end
        
        if isempty(find(padre1(j)==h2(p1:p2)))
            h2(i)=padre1(j);
            i=i+1;
            j=j+1;
        else
            j=j+1;
        end
        
    end
       
    i=1;
    
    while j~=p1 | i~=length(padre2)    
        
        if(j>length(padre2))
           j=1; 
        end
        
       if isempty(find(padre1(j)==h2(1:p1-1)))
            h2(i)=padre1(j);
            i=i+1;
            j=j+1;
        else
            j=j+1;
        end
        
    end

end