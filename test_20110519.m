
clc
clear
argument.hidden=0;
argument.data_type=2;
root_path='/home/ksl/On_line_Signature_verification/MCYT/MCYT_Signature_100';
folders=GetSubfolderList(root_path);

all_signature_global_f=zeros(1,4);
all_signature_global_v=zeros(1,4);

for j=1:length(folders)
    
    files=dir([cell2mat(folders(j)) '/*.fpg']);
    signature_global_feature=zeros(length(files),4);
    for i=1:length(files)
        signature1=Signature_Read([cell2mat(folders(j)) '/' files(i).name],argument);
        global_feature=GetGlobalFeature(signature1,argument);
        signature_global_feature(i,1)=global_feature.total_time;
%         signature_global_feature(i,2)=global_feature.point_number;
        signature_global_feature(i,2)=global_feature.total_long;
        signature_global_feature(i,4)=global_feature.direction_change;
    end
    signature_global_feature(:,1)=signature_global_feature(:,1)/mean(signature_global_feature(26:50,1));
    signature_global_feature(:,2)=signature_global_feature(:,2)/mean(signature_global_feature(26:50,2));
    
    signature_global_feature(:,4)=signature_global_feature(:,4)/mean(signature_global_feature(26:50,4));
    all_signature_global_f=[all_signature_global_f;signature_global_feature(1:25,:)];
    all_signature_global_v=[all_signature_global_v;signature_global_feature(26:50,:)];
end

all_signature_global_f(1,:)=[];
all_signature_global_v(1,:)=[];


scatter3(all_signature_global_f(:,1),all_signature_global_f(:,2),all_signature_global_f(:,4),'r')
hold on
scatter3(all_signature_global_v(:,1),all_signature_global_v(:,2),all_signature_global_v(:,4),'b')

% subplot(3,1,1);
% plot(1:length(all_signature_global_f(:,1)),all_signature_global_f(:,1),'r',...
%     1:length(all_signature_global_v(:,1)),all_signature_global_v(:,1),'b');
% subplot(3,1,2);
% plot(1:length(all_signature_global_f(:,2)),all_signature_global_f(:,2),'r',...
%     1:length(all_signature_global_v(:,2)),all_signature_global_v(:,2),'b');
% subplot(3,1,3);
% plot(1:length(all_signature_global_f(:,4)),all_signature_global_f(:,4),'r',...
%     1:length(all_signature_global_v(:,4)),all_signature_global_v(:,4),'b');

% scatter(all_signature_global_f(:,1),all_signature_global_f(:,4),'r')
% hold on;
% scatter(all_signature_global_v(:,1),all_signature_global_v(:,4),'b')
[mu,sigma,muci,sigmaci] = normfit(all_signature_global_v(:,1));