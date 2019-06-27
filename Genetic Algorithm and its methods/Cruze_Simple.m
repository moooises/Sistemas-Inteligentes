function [h1,h2]=Cruze_Simple(p1,p2)
tail=randi(length(p1))
h1(tail+1:length(p1))=p1(tail+1:length(p1));
h2(tail+1:length(p2))=p2(tail+1:length(p2));
h2(1:tail)=p1(1:tail);
h1(1:tail)=p2(1:tail);
end