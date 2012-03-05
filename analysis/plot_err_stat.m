function plot_err_stat(argument,err_Signature,err_sig_num,err_sig_name,TrainSignature)
pathname_separator_index=strfind(err_sig_name,'/');
image_name=err_sig_name(pathname_separator_index(end)+1:end-4);
plot_index=0;
% gcf=figure;
set(gcf,'outerposition',get(0,'screensize'));
% set(gca,'NextPlot','replacechildren');
% set(gcf,'color','w');
% set(gca,'units','pixels','Visible','off');
% set(gcf,'visible','off');
% q=get(gca,'position');
% q(1)=0;
% q(2)=0;
% set(gca,'position',q);
for i=[2:5]
    subplot(6,3,plot_index*3+1:plot_index*3+3);
    plot_index=plot_index+1;
    hold on;
    temp_result=cell2mat(argument.dtw_result_vector(1));
    plot(1:length(err_Signature),temp_result.signature_1_local_feature(:,i),'r');
%     set(gcf,'visible','off');
    for j=1:length(cell2mat(argument.dtw_result_vector))
        temp_result=cell2mat(argument.dtw_result_vector(j));
        temp_vector=zeros(length(err_Signature),1);
        for k=1:length(err_Signature)
            temp_vector(k)=mean(temp_result.signature_2_local_feature(temp_result.path2(temp_result.path1==k),i));
        end
        plot(1:length(err_Signature),temp_vector,'b');
    end
end
for index=13:17
    subplot(6,3,index);
    temp_signature=cell2mat(TrainSignature(index-12));
    plot(temp_signature(:,1),temp_signature(:,2),'b');
end
subplot(6,3,18);
plot(err_Signature(:,1),err_Signature(:,2),'r');
% print(gcf,'-dpng',[num2str(err_sig_num) '_' image_name '.png']);
%     color_type={'r' 'g' 'b' 'c' 'm' 'y' 'k'};
%     for j=1:length(cell2mat(argument.dtw_result_vector))
%         temp_result=cell2mat(argument.dtw_result_vector(j));
%         temp_dis_matrix=temp_result.dis_matrix;
%         temp_vector=zeros(length(err_Signature),1);
%         for k=1:length(err_Signature)
%             temp_vector(k)=mean(temp_dis_matrix(k,temp_result.path2(find(temp_result.path1,k))));
%         end
%         hold on;
%         plot(1:length(err_Signature),temp_vector,cell2mat(color_type(j)));
%     end
    
% saveas(gcf,[image_name '_' num2str(err_sig_num) '.png'],'png');

imwrite(frame2im(getframe(gcf)),[image_name '_' num2str(err_sig_num) '.png'],'png');
close all;
end
