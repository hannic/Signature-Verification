clc
clear
close all
cd 'D:\Code\ESRA_dev\result\partition-DS2-50';
files=dir('*.txt');
all=zeros(1,8);
same=zeros(1,9);
dif1=zeros(1,9);
dif2=zeros(1,9);

for i=1:size(files,1)
    dat=importdata(files(i).name);
    
%     COEFF=primcomp(dat.data(:,5:7));
    
    for j=1:size(dat.data,1)
        all=[all;dat.data(j,:)];
    end
end
all(1,:)=[];
COEEF=princomp(all(:,5:7));
pca=sum(all(:,5:7).*repmat(COEEF(:,1)',size(all,1),1),2);
temp=zeros(size(all,1),9);
temp(:,1:8)=all;
temp(:,9)=pca;
all=temp;

% 
% for i=1:size(files,1)
%     dat=importdata(files(i).name);
%     
% %     COEFF=primcomp(dat.data(:,5:7));
%     
%     for j=1:size(dat.data,1)
%         all=[all;dat.data(j,2:8)];
%         if(dat.data(j,1)==1.1);
%             same=[same;dat.data(j,2:8)];
%         end
%         if(dat.data(j,1)==0.1)
%             dif1=[dif1;dat.data(j,2:8)];
%         end
%         if(dat.data(j,1)==0.2)
%             dif2=[dif2;dat.data(j,2:8)];
%         end
%     end
% end

for i=1:size(all,1)
    if all(i,1)==1.1
        same=[same;all(i,:)];
    end
    if all(i,1)==0.1
        dif1=[dif1;all(i,:)];
    end
    if all(i,1)==0.2;
        dif2=[dif2;all(i,:)];
    end
end
        
same(1,:)=[];
dif1(1,:)=[];
dif2(1,:)=[];


far1=zeros(8,100);
far2=zeros(8,100);
frr1=zeros(8,100);
frr2=zeros(8,100);
hold on;
for i=2:9
    min_value=min(same(:,i));
%     min_value=mean(same(:,i));
    max_value1=max(dif1(:,i));
%     max_value1=mean(dif1(:,i));
    max_value2=max(dif2(:,i));
    index=1;
    for thresh=min_value:((max_value1-min_value)/99):max_value1
        far1(i-1,index)=sum(same(:,i)>thresh)/size(same,1);
        frr1(i-1,index)=sum(dif1(:,i)<thresh)/size(dif1,1);
        index=index+1;
    end
    index=1;
    for thresh=min_value:((max_value2-min_value)/99):max_value2
        far2(i-1,index)=sum(same(:,i)>thresh)/size(same,1);
        frr2(i-1,index)=sum(dif2(:,i)<thresh)/size(dif2,1);
        index=index+1;
    end
    
end
plot(far1(1,:),frr1(1,:),'g',far1(2,:),frr1(2,:),'b',far1(3,:),frr1(3,:),'c',...
    far1(4,:),frr1(4,:),'m',far1(5,:),frr1(5,:),'y',far1(6,:),frr1(6,:),'--',...
    far1(7,:),frr1(7,:),'r',far1(8,:),frr1(8,:),':')
legend('min','max','avg','mean min','mean max','template','inv','pca')
ylabel('FRR')
xlabel('FAR')
title('1.1-0.1');


figure,plot(far2(1,:),frr2(1,:),'g',far2(2,:),frr2(2,:),'b',far2(3,:),frr2(3,:),'c',...
    far2(4,:),frr2(4,:),'m',far2(5,:),frr2(5,:),'y',far2(6,:),frr2(6,:),'--',...
    far2(7,:),frr2(7,:),'r',far2(8,:),frr2(8,:),':')
legend('min','max','avg','mean min','mean max','template','inv','pca')
ylabel('FRR')
xlabel('FAR')
title('1.1-0.2');



%     for min(same(:,i)):((max(dif1(:,i))-min(same(:,i)))/99):max(dif1(:,i))
        




% COEFF=princomp(same(:,4:6));
% same_pca=zeros(size(same,1),1);
% for 1:size(same_pca,1)
%     same_pca=sum(same(i,4:6).*COFF(:,1)');
% end
% 
% COEFF=princomp(dif1(:,4:6));
% dif1_pca=zeros(size(dif1,1),1);
% for 1:size(dif1_pca,1)
%     dif1_pca=sum(dif1(i,4:6).*COFF(:,1)');
% end
% 
% COEFF=princomp(dif2(:,4:6));
% dif2_pca=zeros(size(dif2,1),1);
% for 1:size(same_pca,1)
%     same_pca=sum(same(i,4:6).*COFF(:,1)');
% end






       

