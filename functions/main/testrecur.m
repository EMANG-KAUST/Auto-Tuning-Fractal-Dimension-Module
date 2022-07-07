fprintf('\n################  breaking bigger regions... ################\n\n') 

% save('pqfile.mat','regions')

i=1;

%r_new=[];
while i<=size(regions,1)
    tl=regions(i,1);
    tr=regions(i,2);
    if tr-tl>=5000        
        regions(i,:)=[];
        [rt] = FD_Analysis(200,200,chan_index,data(:,tl:tr),coefficient);
        regions=[regions;rt+tl];
        continue
    end
    i=i+1;
end