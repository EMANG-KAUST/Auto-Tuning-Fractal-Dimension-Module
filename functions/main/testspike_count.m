le=1+step;
ri=frame_size+step;
regions=events.samples;
in=1;
while ri<size(data,2)
    if spike_count(in)>0
    for j=1:length(regions)
        
    if (abs(regions(j)-ri)<500||abs(regions(j)-le)<500)
        regions(j)=[];
        break;
    end
    end  
    end
    in=in+1;
    le=le+step;
    ri=ri+step;
end