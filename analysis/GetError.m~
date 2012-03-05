 function [ERR]=GetError(Argument)
if strcmp(Argument.ispca,'nopca')&& strcmp(Argument.roc_type,'all')
    cd(Argument.path);
    files=dir('*.txt');
    genuine=zeros(1,Argument.datanumber-1);
    badForgeries=zeros(1,Argument.datanumber-1);
    goodForgeries=zeros(1,Argument.datanumber-1);
    for i=1:size(files,1)
        temp=importdata(files(i).name);
        %         if size(temp.data,2)==data_number+1
        %             temp.data(:,1)=[];
        %         end
        for j=1:size(temp.data,1)
            switch temp.data(j,1)
                case 1.1
                    genuine=[genuine;temp.data(j,2:Argument.datanumber)];
                case 0.1
                    badForgeries=[badForgeries;temp.data(j,2:Argument.datanumber)];
                case 0.2
                    goodForgeries=[goodForgeries;temp.data(j,2:Argument.datanumber)];
            end
        end
    end
    
    genuine(1,:)=[];
    badForgeries(1,:)=[];
    if size(goodForgeries,1)>1
        goodForgeries(1,:)=[];
    end
    
    ERR.far1=zeros(Argument.datanumber-1,Argument.err_length);
    ERR.frr1=ERR.far1;
    ERR.far2=ERR.far1;
    ERR.frr2=ERR.far1;
    ERR.far1_mid=zeros(1,Argument.datanumber-1);
    ERR.frr1_mid=ERR.far1_mid;
    ERR.far2_mid=ERR.far1_mid;
    ERR.frr2_mid=ERR.far1_mid;
    for i=1:Argument.datanumber-1
        index=1;
        
        if strcmp(Argument.thresh_method,'mean')
            lowthresh=mean(genuine(:,i));
            highthresh1=mean(badForgeries(:,i));
        elseif strcmp(Argument.thresh_method,'min_max')
            lowthresh=min(genuine(:,i));
            highthresh1=max(badForgeries(:,i));
        end
        
        if size(goodForgeries,1)>1
            if strcmp(Argument.thresh_method,'mean')
                highthresh2=mean(goodForgeries(:,i));
            elseif strcmp(Argument.thresh_method,'min_max')
                highthresh2=max(goodForgeries(:,i));
            end
        end
        
        for thresh=lowthresh:(highthresh1-lowthresh)/(Argument.err_length-1):highthresh1
            ERR.far1(i,index)=sum(genuine(:,i)>thresh)/size(genuine,1);
            ERR.frr1(i,index)=sum(badForgeries(:,i)<thresh)/size(badForgeries,1);
            index=index+1;
        end
        
        index=1;
        if size(goodForgeries,1)>1
            for thresh=lowthresh:(highthresh2-lowthresh)/(Argument.err_length-1):highthresh2
                ERR.far2(i,index)=sum(genuine(:,i)>thresh)/size(genuine,1);
                ERR.frr2(i,index)=sum(goodForgeries(:,i)<thresh)/size(goodForgeries,1);
                index=index+1;
            end
        end
        
        index=find(abs(ERR.far1(i,:)-ERR.frr1(i,:))==min(abs(ERR.far1(i,:)-ERR.frr1(i,:))));
        ERR.far1_mid(i)=mean(ERR.far1(i,index));
        ERR.frr1_mid(i)=mean(ERR.frr1(i,index));
        ERR.threshed_1(i)=lowthresh+mean((index-1)*(highthresh1-lowthresh)/(Argument.err_length-1));
        
        if size(goodForgeries,1)>1
            index=find(abs(ERR.far2(:,i)-ERR.frr2(:,i))==min(abs(ERR.far2(:,1)-ERR.frr2(:,1))));
            ERR.far2_mid(i)=ERR.far2(i,index);
            ERR.frr2_mid(i)=ERR.frr2(i,index);
            ERR.threshed_2(i)=lowthresh+(index-1)*(highthresh2-lowthresh)/(Argument.err_length-1);
        end
    end
elseif strcmp(Argument.ispca,'pca')&& strcmp(Argument.roc_type,'all')
    cd(Argument.path);
    files=dir('*.txt');
    pca_length=ERR.pca_end-ERR.pca_begin+1;
    all=zeros(1,pca_length+1);
    
    genuine=zeros(1);
    badForgeries=zeros(1);
    goodForgeries=zeros(1);
    
    for i=1:size(files,1)
        temp=importdata(files(i).name);
        %         if size(temp.data,2)==data_number+1
        %             temp.data(:,1)=[];
        %         end
        for j=1:size(temp.data,1)
            ERR.all=[ERR.all;[temp.data(j,1),temp.data(j,pca_begin:pca_end)]];
        end
    end
    [COEFF,SCORE]=princomp(all(:,2:end));
    pca=SCORE(:,1);
    
    for i=1:size(all,1)
        switch all(i,1)
            case 1.1
                genuine=[genuine,pca(i)];
            case 0.1
                badForgeries=[badForgeries,pca(i)];
            case 0.2
                goodForgeries=[goodForgeries,pca(i)];
        end
    end
    
    genuine(1)=[];
    badForgeries(1)=[];
    if length(goodForgeries)>1
        goodForgeries(1)=[];
    end
    
    lowthresh=mean(genuine);
    highthresh1=mean(badForgeries);
    if length(goodForgeries)>1
        highthresh2=mean(goodForgeries);
    end
    
    index=1;
    ERR.far1=zeros(1,Argument.err_length);
    ERR.frr1=ERR.far1;
    ERR.far2=ERR.far1;
    ERR.frr2=ERR.far1;
    
    for thresh=lowthresh:(highthresh1-lowthresh)/(Argument.err_length-1):highthresh1
        ERR.far1(index)=sum(genuine>thresh)/length(genuine);
        ERR.frr1(index)=sum(badForgeries<thresh)/length(badForgeries);
        index=index+1;
    end
    if length(goodForgeries)>1
        index=1;
        
        for thresh=lowthresh:(highthresh2-lowthresh)/(Argument.err_length-1):highthresh2
            ERR.far2(index)=sum(genuine>thresh)/length(genuine);
            ERR.frr2(index)=sum(goodForgeries<thresh)/length(goodForgeries);
            index=index+1;
        end
    end
    index=find(abs(ERR.far1-ERR.frr1)==min(abs(ERR.far1-ERR.frr1)));
    ERR.threshed_1=lowthresh+(index-1)*(highthresh1-lowthresh)/(Argument.err_length-1);
    ERR.far1_mid=mean(ERR.far1(index));
    ERR.frr1_mid=mean(ERR.frr1(index));
    if length(goodForgeries)>1
        index=find(abs(ERR.far2-ERR.frr2)==min(abs(ERR.far2-ERR.frr2)));
        ERR.threshed_2=lowthresh+mean((index-1)*(highthresh2-lowthresh)/(Argument.err_length-1));
        ERR.far2_mid=ERR.far2(index);
        ERR.frr2_mid=ERR.frr2(index);
    end
elseif  strcmp(Argument.ispca,'nopca')&& strcmp(Argument.roc_type,'single')
    cd(Argument.path);
    files=dir('*.txt');
    
    
    ERR.far1_mid=zeros(1,Argument.datanumber-1);
    ERR.frr1_mid=ERR.far1_mid;
    ERR.far2_mid=ERR.far1_mid;
    ERR.frr2_mid=ERR.far1_mid;
    
    for file_index=1:size(files,1)
        genuine=zeros(1,Argument.datanumber-1);
        badForgeries=zeros(1,Argument.datanumber-1);
        goodForgeries=zeros(1,Argument.datanumber-1);
        temp=importdata(files(file_index).name);
        %         if size(temp.data,2)==data_number+1
        %             temp.data(:,1)=[];
        %         end
        for j=1:size(temp.data,1)
            switch temp.data(j,1)
                case 1.1
                    genuine=[genuine;temp.data(j,2:Argument.datanumber)];
                case 0.1
                    badForgeries=[badForgeries;temp.data(j,2:Argument.datanumber)];
                case 0.2
                    goodForgeries=[goodForgeries;temp.data(j,2:Argument.datanumber)];
            end
        end
        
        genuine(1,:)=[];
        badForgeries(1,:)=[];
        if size(goodForgeries,1)>1
            goodForgeries(1,:)=[];
        end
        ERR.far1=zeros(Argument.datanumber-1,Argument.err_length);
        ERR.frr1=ERR.far1;
        ERR.far2=ERR.far1;
        ERR.frr2=ERR.far1;
        
        for i=1:Argument.datanumber-1
            
%             lowthresh=mean(genuine(:,i));
%             highthresh1=mean(badForgeries(:,i));
%             if size(goodForgeries,1)>1
%                 highthresh2=mean(goodForgeries(:,i));
%             end
            if strcmp(Argument.thresh_method,'mean')
                lowthresh=mean(genuine(:,i));
                highthresh1=mean(badForgeries(:,i));
            elseif strcmp(Argument.thresh_method,'min_max')
                lowthresh=min(genuine(:,i));
                highthresh1=max(badForgeries(:,i));
            end
            
            if size(goodForgeries,1)>1
                if strcmp(Argument.thresh_method,'mean')
                    highthresh2=mean(goodForgeries(:,i));
                elseif strcmp(Argument.thresh_method,'min_max')
                    highthresh2=max(goodForgeries(:,i));
                end
            end
            
            index=1;
            for thresh=lowthresh:(highthresh1-lowthresh)/(Argument.err_length-1):highthresh1
                ERR.far1(i,index)=sum(genuine(:,i)>thresh)/size(genuine,1);
                ERR.frr1(i,index)=sum(badForgeries(:,i)<thresh)/size(badForgeries,1);
                index=index+1;
            end
            
            index=1;
            if size(goodForgeries,1)>1
                for thresh=lowthresh:(highthresh2-lowthresh)/(Argument.err_length-1):highthresh2
                    ERR.far2(i,index)=sum(genuine(:,i)>thresh)/size(genuine,1);
                    ERR.frr2(i,index)=sum(goodForgeries(:,i)<thresh)/size(goodForgeries,1);
                    index=index+1;
                end
            end
            
            index=find(abs(ERR.far1(i,:)-ERR.frr1(i,:))==min(abs(ERR.far1(i,:)-ERR.frr1(i,:))));
            ERR.far1_mid(i)=ERR.far1_mid(i)+mean(ERR.far1(i,index))/length(files);
            ERR.frr1_mid(i)=ERR.frr1_mid(i)+mean(ERR.frr1(i,index))/length(files);
            %             ERR.threshed_1(i)=lowthresh+mean((index-1)*(highthresh1-lowthresh)/(Argument.err_length-1));
            
            if size(goodForgeries,1)>1
                index=find(abs(ERR.far2(:,i)-ERR.frr2(:,i))==min(abs(ERR.far2(:,1)-ERR.frr2(:,1))));
                ERR.far2_mid(i)=ERR.far2_mid(i)+ERR.far2(i,index)/length(files);
                ERR.frr2_mid(i)=ERR.frr2_mid(i)+ERR.frr2(i,index)/length(files);
                %                 ERR.threshed_2(i)=lowthresh+(index-1)*(highthresh2-lowthresh)/(Argument.err_length-1);
            end
        end
    end
elseif strcmp(Argument.ispca,'pca') && strcmp(Argument.roc_type,'single')
    cd(path);
    files=dir('*.txt');
    pca_length=pca_end-pca_begin+1;
    ERR.far1_mid=zeros(1);
    ERR.frr1_mid=ERR.far1_mid;
    ERR.far2_mid=ERR.far1_mid;
    ERR.frr2_mid=ERR.far1_mid;
    for i=1:size(files,1)
        all=zeros(1,pca_length+1);
        genuine=zeros(1);
        badForgeries=zeros(1);
        goodForgeries=zeros(1);
        temp=importdata(files(i).name);
        %         if size(temp.data,2)==data_number+1
        %             temp.data(:,1)=[];
        %         end
        for j=1:size(temp.data,1)
            all=[all;[temp.data(j,1),temp.data(j,pca_begin:pca_end)]];
        end
        
        [COEFF,SCORE]=princomp(all(:,2:end));
        pca=SCORE(:,1);
        
        
        for i=1:size(all,1)
            switch all(i,1)
                case 1.1
                    genuine=[genuine,pca(i)];
                case 0.1
                    badForgeries=[badForgeries,pca(i)];
                case 0.2
                    goodForgeries=[goodForgeries,pca(i)];
            end
        end
        
        genuine(1)=[];
        badForgeries(1)=[];
        if length(goodForgeries)>1
            goodForgeries(1)=[];
        end
        
        lowthresh=mean(genuine);
        highthresh1=mean(badForgeries);
        if length(goodForgeries)>1
            highthresh2=mean(goodForgeries);
        end
        
        index=1;
        ERR.far1=zeros(1,Argument.err_length);
        ERR.frr1=ERR.far1;
        ERR.far2=ERR.far1;
        ERR.frr2=ERR.far1;
        
        for thresh=lowthresh:(highthresh1-lowthresh)/(Argument.err_length-1):highthresh1
            ERR.far1(index)=sum(genuine>thresh)/length(genuine);
            ERR.frr1(index)=sum(badForgeries<thresh)/length(badForgeries);
            index=index+1;
        end
        if length(goodForgeries)>1
            index=1;
            
            for thresh=lowthresh:(highthresh2-lowthresh)/(Argument.err_length-1):highthresh2
                ERR.far2(index)=sum(genuine>thresh)/length(genuine);
                ERR.frr2(index)=sum(goodForgeries<thresh)/length(goodForgeries);
                index=index+1;
            end
        end
        index=find(abs(ERR.far1-ERR.frr1)==min(abs(ERR.far1-ERR.frr1)));
        ERR.threshed_1=lowthresh+(index-1)*(highthresh1-lowthresh)/(Argument.err_length-1);
        ERR.far1_mid= ERR.far1_mid+mean(ERR.far1(index))/length(files);
        ERR.frr1_mid=ERR.frr1_mid+mean(ERR.frr1(index))/length(files);
        if length(goodForgeries)>1
            index=find(abs(ERR.far2-ERR.frr2)==min(abs(ERR.far2-ERR.frr2)));
            ERR.far2_mid=ERR.far2_mid+ERR.far2(index)/length(files);
            ERR.frr2_mid=ERR.frr2_mid+ERR.frr2(index)/length(files);
        end
    end
end






