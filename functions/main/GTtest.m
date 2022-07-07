GT=events.samples;
count=0;
for i=1:length(GT)
    for j=1:size(regions,1)
        left=regions(j,1);
        right=regions(j,2);
        if GT(i)>left&GT(i)<right
            count=count+1;
            break
        end
    end
end