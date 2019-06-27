function v=Inserccion(v)
p1=randi(length(v));
p2=randi(length(v));
while p2==p1
    p2=randi(length(v));
end

if p1>p2
    aux=p1;
    p1=p2;
    p2=aux;
end
if abs(p1-p2)~=1
t=v(p1);
v(p1:p2-2)=v(p1+1:p2-1);
v(p2-1)=t;
end

end