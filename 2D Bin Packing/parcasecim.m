function parcasecim=parcasecim(FTV)
for i=1:length(FTV)
    parcasecim(1,i)=0;
end
it=1;
while it<length(FTV)+1
    gelen=round(1+(length(FTV)-1)*rand());
    if(ismember(gelen,parcasecim)~=0)
        gelen=round(1+(length(FTV)-1)*rand());
    else
        parcasecim(1,it)=gelen;
        it=it+1;
    end
end

end