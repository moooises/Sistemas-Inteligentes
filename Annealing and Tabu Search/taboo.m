function taboo()
%%% = 20*x1 + 25*x2 - 30*x3 - 45*x4 + 40*x5
actual=[1,0,0,0,1];
Mejor=actual;
Iter=1;
r=1;
Taboo_list=zeros(1,length(actual));
ternure=4;
while Iter~=1000

    suc=Sucesores(actual);
    
    while (size(suc,1)~=r)
        New=suc(r,:);
        if Coste(New(1:length(actual)))<Coste(Mejor(1:length(actual)))
           
           actual(1:length(actual))=New(1:length(actual));
           Mejor(1:length(actual))=actual(1:length(actual));
           
           Taboo_list(suc(r,size(suc,2)))=ternure;
           r=size(suc,1);
          

        else
            if Taboo_list(New(length(actual)+1))==0
               actual(1:length(actual))=New(1:length(actual));
               Taboo_list(suc(r,length(actual)+1))=ternure;
               r=size(suc,1);


            else
                
                r=r+1;
            end
        end
    end
    suc={};
    r=1;
    Taboo_list=Taboo_list-1;
    Taboo_list(find(Taboo_list<0))=0;
    Iter=Iter+1;
end
Iter
Mejor
coste=Coste(Mejor)
end

function suc=Sucesores(actual)

for i=1:length(actual)
    suc(i,1:length(actual))=actual;
    if(suc(i,i)==0)
        suc(i,i)=1;
    else
        suc(i,i)=0;
    end
    suc(i,length(actual)+1)=i;
    C(i)=Coste(suc(i,:));
    C(i)=C(i)+Penalizacion(suc(i,:));
end
COrd=sort(C);
aux=suc;
for t=1:length(C)
    pos=find(COrd(t)==C);
    if(length(pos)==1)
        suc(t,:)=aux(pos,:);
    else
         cant=1;
       while  length(pos)~=cant
           suc(t,:)=aux(pos(cant),:);
           t=t+1;
           cant=cant+1;
       end
    end
end
suc
end

function p=Penalizacion(estado)
p=0;
if(estado(1)+estado(2)-estado(3)+estado(4)+estado(5)>=1)p=p+70;end
if(estado(1)+estado(2)-estado(4)+2*estado(5)>=2)p=p+70;end
if(-estado(2)+estado(4)+estado(5)<=1)p=p+100;end
if(-estado(2)+estado(3)+estado(5)<=2)p=p+100;end

end

function c=Coste(suc)
c=20*suc(1) + 25*suc(2) - 30*suc(3) - 45*suc(4) + 40*suc(5);
c=c+Penalizacion(suc);
end
