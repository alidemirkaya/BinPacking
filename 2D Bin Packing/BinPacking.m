function Pack=BinPacking(parca,sira,PaketKapasitesi)

Pack(1).Yerles(1).no=0;
Pack(1).Yerles(1).boy=0;
for i=1:length(sira)
    parca_boyut=parca(sira(i)).boy;
    yerlestimi=0;
    for j=1:length(Pack)
        if(sum(vertcat(Pack(j).Yerles.boy))+parca_boyut <= PaketKapasitesi)
            Pack(j).Yerles(end+1).no=parca(sira(i)).no;
            Pack(j).Yerles(end).boy=parca(sira(i)).boy;
            yerlestimi=1;
        end            
    end
    if(yerlestimi==0)
        Pack(end+1).Yerles(1).no=parca(sira(i)).no;
        Pack(end).Yerles(1).boy=parca(sira(i)).boy;
        yerlestimi=1;
    end  
end