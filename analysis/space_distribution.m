function space_distribution(path,data_begin,data_end)
cd(path)
files=dir('*.txt');
same=zeros(1,3);
dif1=zeros(1,3);
dif2=zeros(1,3);

for i=1:length(files)
    temp=importdata(files(i).name);
    if size(temp.data,2)==4+1
        temp.data(:,1)=[];
    end
    for j=1:size(temp.data,1)
        switch temp.data(j,1)
            case 1.1
                same=[same;temp.data(j,data_begin:data_end)];
            case 0.1
                dif1=[dif1;temp.data(j,data_begin:data_end)];
            case 0.2
                dif2=[dif2;temp.data(j,data_begin:data_end)];
        end
    end
end
X=zeros(max([length(same),length(dif1),length(dif2)]),3);
Y=X;
Z=X;
X(1:length(same),1)=same(:,1);
X(1:length(dif1),2)=dif1(:,1);
X(1:length(dif2),3)=dif2(:,1);
Y(1:length(same),1)=same(:,2);
Y(1:length(dif1),2)=dif1(:,2);
Y(1:length(dif2),3)=dif2(:,2);
Z(1:length(same),1)=same(:,3);
Z(1:length(dif1),2)=dif1(:,3);
Z(1:length(dif2),3)=dif2(:,3);

S = repmat([1 .75 .5]*10,length(X),1);
C = repmat([1 2 3],length(X),1);
scatter3(X(:),Y(:),Z(:),S(:),C(:))
grid on

