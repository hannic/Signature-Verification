function [far1 frr1 far1_mid frr1_mid far2 frr2 far2_mid frr2_mid]=my_roc(path)
err_length=100;
cd (path);
files=dir('*.txt');
same=zeros(1);
dif1=zeros(1);
dif2=zeros(1);
for i=1:length(files)
    temp=importdata(files(i).name);
    for j=1:length(temp)
        switch temp(j,2)
            case 1.1
                same=[same temp(j,3)];
            case 0.1
                dif1=[dif1 temp(j,3)];
            case 0.2
                dif2=[dif2 temp(j,3)];
        end
    end
end


same(1)=[];
dif1(1)=[];
dif2(1)=[];

lowthresh=mean(same);
highthresh1=mean(dif1);
highthresh2=mean(dif2);

index=1;
far1=zeros(1,err_length);
frr1=far1;
far2=far1;
frr2=far1;

for thresh=lowthresh:(highthresh1-lowthresh)/(err_length-1):highthresh1
    far1(index)=sum(same>thresh)/length(same);
    frr1(index)=sum(dif1<thresh)/length(dif1);
    index=index+1;
end

index=1;

for thresh=lowthresh:(highthresh2-lowthresh)/(err_length-1):highthresh2
    far2(index)=sum(same>thresh)/length(same);
    frr2(index)=sum(dif2<thresh)/length(dif2);
    index=index+1;
end

index=find(abs(far1-frr1)==min(abs(far1-frr1)));
far1_mid=far1(index);
frr1_mid=frr1(index);
index=find(abs(far2-frr2)==min(abs(far2-frr2)));
far2_mid=far2(index);
frr2_mid=frr2(index);

