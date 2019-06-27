function v=inversion(v);
p1=randi(length(v));
p2=randi(length(v));
while p2==p1
    p2=randi(length(v));
end

if p2<p1
    aux=p1;
    p1=p2;
    p2=aux;
end

aux=fliplr(v(p1:p2));
v(p1:p2)=aux;

end