function get_mean_dif(path,data_number)
cd(path)
files=dir('*.txt');
% same_mean=zeros(1,length(files));
% dif1_mean=zeros(1,length(files));
% dif2_mean=zeros(1,length(files));
%DS2-50 gamma=6
% threshed=1.6353
%DS2_50-1
threshed=1.5637;
for i=1:size(files,1)
    same=zeros(1,data_number-1);
    dif1=zeros(1,data_number-1);
    dif2=zeros(1,data_number-1);
    temp=importdata(files(i).name);
    if size(temp.data,2)==data_number+1
        temp.data(:,1)=[];
    end
    for j=1:length(temp.data)
        switch temp.data(j,1)
            case 1.1
                same=[same;temp.data(j,2:4)];
            case 0.1
                dif1=[dif1;temp.data(j,2:4)];
            case 0.2
                dif2=[dif2;temp.data(j,2:4)];
        end
    end
    same(1,:)=[];
    dif1(1,:)=[];
    dif2(1,:)=[];
    figure(1);
    subplot(5,10,i);
    plot(1:length(same),same(:,1),'r',1:length(same),same(:,2),'r--',...
        1:length(same),same(:,data_number-1),'r:',1:length(dif1),dif1(:,1),'b',...
        1:length(dif1),dif1(:,2),'b--',1:length(dif1),dif1(:,data_number-1),'b:');
    title(files(i).name);
    %         subplot(5,10,i);plot(1:length(same),same,'r',1:length(dif2),dif2,'g');
    %         legend('1.1','0.1','0.2');
    grid on;
    figure(2);
    subplot(5,10,i);
        plot(1:length(same),same(:,1),'r',1:length(same),same(:,2),'r--',...
        1:length(same),same(:,data_number-1),'r:',1:length(dif2),dif2(:,1),'b',...
        1:length(dif2),dif2(:,2),'b--',1:length(dif2),dif2(:,data_number-1),'b:');
    title(files(i).name);
    
    
end

%     print(gcf,'-dpng',[path '_1.1_0.1.png']);
% legend('1.1','0.1');
%         legend('1.1','0.2');
