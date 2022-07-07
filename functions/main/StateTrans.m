function [isEnd,Th,SS,PS,Ind,bl,br] = StateTrans(Th,SS,PS,bl,br,Ind,IndMax,SearchD,spike_count)
%State Transform realization of the paper
% modification of FD's global state

isEnd=0;    %stoping flag

if SS==0    %not in scaning phase (coarse search)
    fprintf('\n not in scaning phase (coarse search)  \n\n')
    %judge
    if ratiojudge(spike_count)==3
        %three scenarios, depending on PS
        if PS(end)==1
            %first scenario, possible new scaning interval found
            fprintf('\n  first scenario, possible new scaning interval found \n\n')
            SS=1;
            bl=Th/SearchD;
            br=Th;
            Th=bl;%Th update
            PS(end+1)=1;
            isEnd=0;
            Ind=1;
            return;
        elseif PS(end)==3
            %second scehnario, searching with SearchD
            fprintf('\n second scehnario, searching with SearchD \n\n')
            SS=0;
            Th=Th/SearchD;%Th Update
            PS(end+1)=3;
            isEnd=0;
            return;
        else
            %third scenario, just started the search
            fprintf('\n third scenario, just started the search \n\n')
            SS=0;
            Th=Th/SearchD;%Th Update 
            PS(end+1)=3;
            isEnd=0;
            return;
        end
        
    elseif ratiojudge(spike_count)==1
        %two scenarios, depending on PS
        if PS(end)==3
            %first scenario, possible new scaning interval found
            fprintf('\n first scenario, possible new scaning interval found \n\n')
            SS=1;
            bl=Th;
            br=Th*SearchD;
            Th=bl;%Th Update
            PS(end+1)=1;
            isEnd=0;
            Ind=1;
            return;
        elseif PS(end)==1
            %second scehnario, searching with SearchD
            fprintf('\n second scehnario, searching with SearchD \n\n')
            SS=0;
            Th=Th*SearchD;%Th Update
            PS(end+1)=1;
            isEnd=0;
            return;
        else
            %third scenario, just started the search
            fprintf('\n third scenario, just started the search \n\n')
            SS=0;
            Th=Th*SearchD;%Th Update
            PS(end+1)=1;
            isEnd=0;
            return;
        end   
        
    elseif ratiojudge(spike_count)==2
        %right one, stop the search!
        fprintf('\n right one, stop the search! \n\n')
        isEnd=1;
        return;
    end
    
elseif SS==1
    %it is in scanning phase, where PS(end)>=3
    fprintf('\n it is in scanning phase, where PS(end)>=3 \n\n')
    if Ind==IndMax
        % whole intervals searched, the new scan range is the last interval
        fprintf('\n whole intervals searched, the new scan range is the last interval \n\n')
        SS=1;
        bl=Th;
        Th=bl;%Th Update
        PS(end+1)=1;
        isEnd=0;
        Ind=1;
        return; 
    else
        if ratiojudge(spike_count)==1
            %potential Th lies after, keep searching up
            fprintf('\n potential Th lies after, keep searching up \n\n')
            SS=1;
            PS(end+1)=1;
            isEnd=0;
            Th=bl+(br-bl)/(IndMax-1)*Ind;
            Ind=Ind+1;
            return
            
        elseif ratiojudge(spike_count)==3
            if PS(end)~=1
                error('program bug, some state not considered')
            end
            %new search regions spotted
            fprintf('\n new search regions spotted \n\n')
            SS=1;
            PS(end+1)=1;
            isEnd=0;
            bl=bl+(br-bl)/(IndMax-1)*(Ind-1);
            br=Th;
            Th=bl;
            Ind=1;
            return;
            
        elseif ratiojudge(spike_count)==2
        %right one, stop the search!
        fprintf('\n right one, stop the search! \n\n')
        isEnd=1;
        return;
                                                                      
        end    
    end
    
end
            
            
            
    





end

