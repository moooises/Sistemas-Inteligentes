function s=graphColour(k,m,x,G,n)
   for c=1:1:m
       p=isSafe(k,c,x,G,n);
        if (p==1)
            x(k)=c;
            if(k+1<=n)
            graphColour(k+1,m,x,G,n);
            else 
            disp(x); return;
            end
        end
         s=1;
   end

end

function r=isSafe(k,c,x,G,n)
i=1;
    while i<n%for i=0:1:n %cambiar for por while
        if G(k,i)==1
            if c==x(i)
            r=0; return;
            end
        end
    i=i+1;
    end
        r=1; return;   
end

