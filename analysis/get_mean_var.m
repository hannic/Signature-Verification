function [all all2]=get_mean_var(path)
cd(path);
flods=dir('*')
root=pwd;
all=zeros(1);
all2=zeros(1,2);
for i=3:size(flods,1)
    cd(flods(i).name);
    subflods=dir('*');
    temp=zeros(1);
    for j=3:size(subflods,1)
        cd(subflods(j).name);
        files=dir('*.txt');
        temp=zeros(1);
        for k=1:size(files,1)
            a=importdata(files(k).name);
            all=[all;a(:,4)];
            temp=[temp;a(:,4)];
%             cd('..');
        end
        
        cd('..');
    end
    temp(1,:)=[];
    all2=[all2;mean(temp) std(temp)];
    cd('..');
end
        
            
        
    