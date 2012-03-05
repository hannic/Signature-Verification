function [result]=GetROC(dir,data_number,data_type,show_im,roc_type,GetErr)

line_type={'-' '--' ':' '-.'};
color_type={'r' 'g' 'b' 'c' 'm' 'y' 'k'};
marker_type={'+' 'o' '*' '.' 'x' 's' 'd' '^' 'v' '<' '>' 'p' 'h'};
type=cell(length(line_type)*length(color_type)*length(marker_type));
ind=1;
for ind1=1:length(line_type)
    for ind2=1:length(color_type)
        for ind3=1:length(marker_type)
            type(ind)={[cell2mat(line_type(ind1)) cell2mat(color_type(ind2)) cell2mat(marker_type(ind3))]};
            ind=ind+1;
        end
    end
end

cd(dir)



argument.path=dir;
argument.datanumber=data_number;
argument.thresh_method='mean';
argument.err_length=100;
argument.ispca='nopca';


if roc_type==1
    argument.roc_type='all';
    [result]=GetError(argument);
elseif roc_type==2
    argument.roc_type='single';
    result=GetError(argument);
end
if GetErr==1
    temp_err=result.far1_mid+result.frr1_mid;
    temp_index=find(temp_err==min(temp_err));
    index=temp_index(1);
%     for index=1:length(temp_err)
        GetErrorName(argument,result,index);
%     end
end

% if data_type==1 && roc_type==1
%     result=GetError(pwd,0,100,'pca',data_number,'all',2,data_number);
% elseif data_type==1 && roc_type==2
%     result=GetError(pwd,0,100,'pca',data_number,'single',2,data_number);
% elseif data_type==2
% end

if show_im==1
    h=figure;
    subplot(2,2,1);
    
    hold on
    for i=1:data_number-1
        plot(result.far1(i,:),result.frr1(i,:),cell2mat(type(i)));
    end
    xlim([0 0.1])
    ylim([0 0.1])
    %     if data_type==2
    %         legend('mmin','mmax','template','pressure','pca');
    %     elseif data_type==1
    %         legend('mmin','mmax','template','pca');
    %     end
    grid on
    xlabel('FAR');
    ylabel('FRR');
    title('1.1-0.1')
    tempmid=(result.far1_mid+result.frr1_mid)/2;
    
    subplot(2,2,2);
    plot(tempmid,'*');
    
    
    ylim([0 1]);
    grid on;
    
    if data_type==2
        subplot(2,2,3);
        
        hold on
        for i=1:data_number
            plot(result.far1(i,:),result.frr1(i,:),cell2mat(type(i)));
        end
        %         legend('mmin','mmax','template','pressure','pca');
        grid on;
        xlabel('FAR');
        ylabel('FRR');cd
        title('1.1-0.2');
        
        subplot(2,2,4);
        plot(1:length(result.far2_mid),result.far2_mid,1:length(result.frr2_mid),result.frr2_mid);
        for i=1:length(result.far2_mid)
            text(i,result.far2_mid(i),char(vpa(result.far2_mid(i),data_number)),'VerticalAlignment','top')
            text(i,result.frr2_mid(i),char(vpa(result.frr2_mid(i),data_number)),'VerticalAlignment','bottom');
        end
        ylim([0 1])
        grid on;
        set(gca,'XTickLabel',{'mmin','mmax','template','pressure','pca'});
    end
    
    saveas(h,[num2str(roc_type) '.png'],'png')
    
end
end

