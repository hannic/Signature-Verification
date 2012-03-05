
function plot_roc(dir)
% clc
% clear
% close all
% hold on
% type={'r' 'g' 'b' 'c' 'm' 'y' 'k' '-'};
% typename={'min' 'max' 'avg' 'mmin' 'mmax' 'template' 'inv','pca'}
cd(dir)
far1=zeros(7,100);
frr1=far1;
far2=far1;
frr2=far1;
far1_mid=zeros(7,1);
frr1_mid=zeros(7,1);
far2_mid=zeros(7,1);
frr2_mid=zeros(7,1);
for i=2:7
[far1(i-1,:)  frr1(i-1,:) far1_mid(i-1,1) frr1_mid(i-1,1) far2(i-1,:) ...
    frr2(i-1,:) far2_mid(i-1,1) frr2_mid(i-1,1)]=GetError(pwd,i,100,'nopca');
end
[far1(7,:) frr1(7,:) far1_mid(7,1) frr1_mid(7,1) far2(7,:) frr2(7,:)...
    far2_mid(7,1) frr2_mid(7,1)]=GetError(pwd,i,100,'pca',5,7);

subplot(2,2,1);plot(far1(1,:),frr1(1,:),'r',far1(2,:),frr1(2,:),'g',far1(3,:),frr1(3,:),'b',...
    far1(4,:),frr1(4,:),'c',far1(5,:),frr1(5,:),'m',far1(6,:),frr1(6,:),'b-.',...
    far1(7,:),frr1(7,:),'k');
legend('min','max','avg','mmin','mmax','template','pca');

grid on
xlabel('FAR');
ylabel('FRR');
title('1.1-0.1')

subplot(2,2,2);plot(1:length(far1_mid),far1_mid,1:length(frr1_mid),frr1_mid);
for i=1:length(far1_mid)
    text(i,far1_mid(i),char(vpa(far1_mid(i),4)),'VerticalAlignment','top')
end
for i=1:length(frr1_mid)
    text(i,frr1_mid(i),char(vpa(frr1_mid(i),4)),'VerticalAlignment','bottom');
end
ylim([0 1]);
grid on;
set(gca,'XTickLabel',{'min','max','avg','mmin','mmax','template','pca'});

subplot(2,2,3);plot(far2(1,:),frr2(1,:),'r',far2(2,:),frr2(2,:),'g',far2(3,:),frr2(3,:),'b',...
    far2(4,:),frr2(4,:),'c',far2(5,:),frr2(5,:),'m',far2(6,:),frr2(6,:),'b-.',...
    far2(7,:),frr2(7,:),'k');
legend('min','max','avg','mmin','mmax','template','pca');
grid on;
xlabel('FAR');
ylabel('FRR');
title('1.1-0.2');

subplot(2,2,4);plot(1:length(far2_mid),far2_mid,1:length(frr2_mid),frr2_mid);
for i=1:length(far2_mid)
    text(i,far2_mid(i),char(vpa(far2_mid(i),4)),'VerticalAlignment','top')
end
for i=1:length(frr2_mid)
    text(i,frr2_mid(i),char(vpa(frr2_mid(i),4)),'VerticalAlignment','bottom');
end
ylim([0 1])
grid on;
set(gca,'XTickLabel',{'min','max','avg','mmin','mmax','template','pca'});