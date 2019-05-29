function C=Crossover(E1,E2)

kesim=round(2+((length(E1)-1)-1)*rand());
for i=1:kesim
    C1(i)=E1(i);
    C2(i)=E2(i);
end
for i=kesim+1:length(E1)
    if(find(C1==E2(i))>0)
    else
        C1(end+1)=E2(i);
    end
    if(find(C2==E1(i))>0)
    else
        C2(end+1)=E1(i);
    end
end
for i=1:kesim
    if(find(C1==E2(i))>0)
    else
        C1(end+1)=E2(i);
    end
    if(find(C2==E1(i))>0)
    else
        C2(end+1)=E1(i);
    end
end
C(1,:)=C1;
C(2,:)=C2;
end    