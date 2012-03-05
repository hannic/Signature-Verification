type={'r' 'g' 'b' 'c' 'm' 'y' 'k' '-' ':' '--' '-.' '+' 'o'};
% typename={'min' 'max' 'avg' 'mmin' 'mmax' 'template' 'inv','pca'}

templat_far1=zeros(10,100);
templat_far2=templat_far1;
templat_frr1=templat_far1;
templat_frr2=templat_far1;
template_far1_mid=zeros(1,10);
template_far2_mid=zeros(1,10);
template_frr1_mid=zeros(1,10);
template_frr2_mid=zeros(1,10);


% figure h;
% x y dx dy p dp
path2='/home/ksl/On_line_Signature_verification/ESRA/ESRA_dev/result//partition-DS2-50-1_5';
%x y dx dy p dp all
path1='/home/ksl/On_line_Signature_verification/ESRA/ESRA_dev/result//partition-DS2-50-1_7';
%x y dx dy 
path3='/home/ksl/On_line_Signature_verification/ESRA/ESRA_dev/result//partition-DS2-50-1_17';
%y dx dy p
path4='/home/ksl/On_line_Signature_verification/ESRA/ESRA_dev/result//partition-DS2-50-1_25';

for i=1:4
cd(eval(['path' num2str(i)]));
[far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC(pwd,5,1,1,1);
templat_far1(i,:)=far1(3,:);
templat_far2(i,:)=far2(3,:);
templat_frr1(i,:)=frr1(3,:);
templat_frr2(i,:)=frr2(3,:);
template_far1_mid(i)=far1_mid(3);
template_far2_mid(i)=far2_mid(3);
template_frr1_mid(i)=frr1_mid(3);
template_frr2_mid(i)=frr2_mid(3);
end


cd('/home/ksl/On_line_Signature_verification/ESRA');

h=figure;
subplot(2,2,1);
hold on
for i=1:2
plot(templat_far1(i,:),templat_frr1(i,:),cell2mat(type(i)));
end
legend('x_y_dx_dy_p_dp_all','x_y_dx_dy_p_dp_one');

subplot(2,2,2)
hold on
plot(template_far1_mid(1:2),'r');
plot(template_frr1_mid(1:2),'g');
for i=1:2
    text(i,template_far1_mid(i),char(vpa(template_far1_mid(i),3)),'VerticalAlignment','top')
    text(i,template_frr1_mid(i),char(vpa(template_frr1_mid(i),3)),'VerticalAlignment','bottom');
end
set(gca,'XTickLabel',{'x_y_dx_dy_p_dp_all','x_y_dx_dy_p_dp_one'});
subplot(2,2,3)
hold on
for i=1:2
plot(templat_far2(i,:),templat_frr2(i,:),cell2mat(type(i)));
end
legend('x_y_dx_dy_p_dp_all','x_y_dx_dy_p_dp_one');
subplot(2,2,4)
hold on
plot(template_far2_mid(1:2),'r');
plot(template_frr2_mid(1:2),'g');
for i=1:2
    text(i,template_far2_mid(i),char(vpa(template_far2_mid(i),3)),'VerticalAlignment','top')
    text(i,template_frr2_mid(i),char(vpa(template_frr2_mid(i),3)),'VerticalAlignment','bottom');
end
set(gca,'XTickLabel',{'x_y_dx_dy_p_dp_all','x_y_dx_dy_p_dp_one'});

saveas(h,'1.png','png');
% close all

g=figure;
subplot(2,2,1);
hold on
for i=2:4
plot(templat_far1(i,:),templat_frr1(i,:),cell2mat(type(i)));
end
legend('x_y_dx_dy_p_dp','x y dx dy','y dx dy p');

subplot(2,2,2)
hold on
plot(template_far1_mid(2:4),'r');
plot(template_frr1_mid(2:4),'g');
for i=2:4
    text(i,template_far1_mid(i),char(vpa(template_far1_mid(i),3)),'VerticalAlignment','top')
    text(i,template_frr1_mid(i),char(vpa(template_frr1_mid(i),3)),'VerticalAlignment','bottom');
end
set(gca,'XTickLabel',{'x_y_dx_dy_p_dp','x_y_dx_dy','y_dx_dy_p'});


subplot(2,2,3)
hold on
for i=2:4
plot(templat_far2(i,:),templat_frr2(i,:),cell2mat(type(i)));
end
legend('x_y_dx_dy_p_dp','x y dx dy','y dx dy p');


subplot(2,2,4)
hold on
plot(template_far1_mid(2:4),'r');
plot(template_frr1_mid(2:4),'g');
for i=2:4
    text(i,template_far1_mid(i),char(vpa(template_far1_mid(i),3)),'VerticalAlignment','top')
    text(i,template_frr1_mid(i),char(vpa(template_frr1_mid(i),3)),'VerticalAlignment','bottom');
end
set(gca,'XTickLabel',{'x_y_dx_dy_p_dp','x_y_dx_dy','y_dx_dy_p'});

saveas(g,'2.png','png');
% close all
