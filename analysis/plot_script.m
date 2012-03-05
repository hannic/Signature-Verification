% h=figure;
% hold on;
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/11',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'--r*')
% err1=(far1_mid(3)+frr1_mid(3))/2;
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/10',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'-+')
% err2=(far1_mid(3)+frr1_mid(3))/2;
% xlim([0,10])
% ylim([0,10])
% xlabel('False Acceptance Rate (%)')
% ylabel('False Rejection Rate (%)')
% title('MCYC DB,100 signers,5 signatures/signer train,20 genuine signature 25 skill forgeries/signers test')
% legend('Euclidean distance','Mahalanobis distance')
% grid on
% 
% close all

% err1=err1*100;
% err2=err2*100;
% h=figure;
% bar([1,2],[err1,err2]);
% text(1,err1,char(vpa(err1,3)),'VerticalAlignment','bottom');
% text(2,err2,char(vpa(err2,3)),'VerticalAlignment','bottom');
% set(gca,'XTickLabel',{'Euclidean distance','Mahalanobis distance'});
% ylim([0 10]);
% ylabel('ERR (%)')

% Specifiers_type={'+','o','*','.','x','s','d','^','v','>','<','p','h'};
% color_type={'r','g','b','m','y','k'};
% line_type={'-','--',':','-.'};
% close all
% h=figure;
% err=zeros(1,4);
% hold on;
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/1',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'--k+')
% err(1)=(far1_mid(3)+frr1_mid(3))/2;
% 
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/5',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'--ro')
% err(2)=(far1_mid(3)+frr1_mid(3))/2;
% 
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/8',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'--m*')
% err(3)=(far1_mid(3)+frr1_mid(3))/2;
% 
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/10',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'--bs')
% err(4)=(far1_mid(3)+frr1_mid(3))/2;
% grid on
% xlim([0,10])
% ylim([0,10])
% xlabel('False Acceptance Rate (%)')
% ylabel('False Rejection Rate (%)')
% title('MCYC DB,100 signers,5 signatures/signer train,20 genuine signature 25 skill forgeries/signers test')
% legend('x y dx dy p dp','y dx dy p dp','y dx dy','y dx dy p')
% close all;
% err=err*100;
% bar(err,0.5)
% for i=1:4
% text(i,err(i),char(vpa(err(i),3)),'VerticalAlignment','bottom','HorizontalAlignment','center');
% end
% set(gca,'XTickLabel',{'x y dx dy p dp','y dx dy p dp','y dx dy','y dx dy p'});
% ylim([0 5]);
% ylabel('ERR (%)')



Specifiers_type={'+','o','*','.','x','s','d','^','v','>','<','p','h'};
h=figure;
hold on;
err=zeros(1,5);
[far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/11',4,1,0,1);
far1 =far1*100;
frr1=frr1*100;
plot(far1(3,:),frr1(3,:),'--rx')
err(1)=(far1_mid(3)+frr1_mid(3))/2;
[far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/1',4,1,0,1);
far1 =far1*100;
frr1=frr1*100;
plot(far1(3,:),frr1(3,:),'--k+')
err(2)=(far1_mid(3)+frr1_mid(3))/2;
% [far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/2',4,1,0,1);
% far1 =far1*100;
% frr1=frr1*100;
% plot(far1(3,:),frr1(3,:),'--ro')
% err(3)=(far1_mid(3)+frr1_mid(3))/2;
[far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/16',4,1,0,1);
far1 =far1*100;
frr1=frr1*100;
plot(far1(3,:),frr1(3,:),'--b*')
err(3)=(far1_mid(3)+frr1_mid(3))/2;
[far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/17',4,1,0,1);
far1 =far1*100;
frr1=frr1*100;
plot(far1(3,:),frr1(3,:),'--gs')
err(4)=(far1_mid(3)+frr1_mid(3))/2;
[far1 frr1 far2 frr2 far1_mid frr1_mid far2_mid frr2_mid]=GetROC('/home/ksl/MCYT_result/18',4,1,0,1);
far1 =far1*100;
frr1=frr1*100;
plot(far1(3,:),frr1(3,:),'--md')
err(5)=(far1_mid(3)+frr1_mid(3))/2;
grid on
xlim([0,10])
ylim([0,10])
xlabel('False Acceptance Rate (%)')
ylabel('False Rejection Rate (%)')
title('MCYC DB,100 signers')
legend('ED','MSV','MDV-RT','MDV-ST \alpha=0.01','MDV-ST \alpha=0.1')
close all
err=err*100;
bar(err,0.5)
type_1={'ED','MSV','MDV-RT','MDV-ST \alpha=0.01','MDV-ST \alpha=0.1'};
for i=1:5
text(i,err(i),char(vpa(err(i),3)),'VerticalAlignment','bottom','HorizontalAlignment','center');
text(i,err(i)+1,type_1(i),'VerticalAlignment','bottom','HorizontalAlignment','center');
end
% set(gca,'XTickLabel',{'ED','MSV','MDV-RT','MDV-ST alpha=0.01','MDV-ST alpha=0.1'});
% legend('ED','MSV','MDV-RT','MDV-ST \alpha=0.01','MDV-ST \alpha=0.1')
ylim([0 7]);
ylabel('ERR (%)')


% signature1=cell2mat(TrainSignature(1));
% signature2=TestSignature;
% % signature2=cell2mat(TrainSignature(2));
% signature1(:,1:2)=signature1(:,1:2)-repmat(signature1(1,1:2),length(signature1),1);
% signature2(:,1:2)=signature2(:,1:2)-repmat(signature2(1,1:2)+[0,500],length(signature2),1);
% plot(signature1(:,1),signature1(:,2),'r',signature2(:,1),signature2(:,2),'k');
% for i=1:DTW_result.len
%     line([signature1(DTW_result.path1(i),1),signature2(DTW_result.path2(i),1)],[signature1(DTW_result.path1(i),2),signature2(DTW_result.path2(i),2)]);
% end

% plot(DTW_result.path1(1:DTW_result.len),DTW_result.path2(1:DTW_result.len))




