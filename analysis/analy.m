function [dif_dis_std,dif_speed_std,dif_dx_std,dif_dy_std,same_dis_std,same_speed_std,same_dx_std,same_dy_std,dif_time_dif same_time_dif]=analy(path)
% cd('/home/ksl/ESRA_dev/result/partition-DS2-50_2')
cd(path);
files=dir('*.txt');
data_path='/home/ksl/ESRA_dev';

dif_dis_std=zeros(1);
dif_speed_std=zeros(1);
dif_dx_std=zeros(1);
dif_dy_std=zeros(1);
dif_time_dif=zeros(1);

same_dis_std=zeros(1);
same_speed_std=zeros(1);
same_dx_std=zeros(1);
same_dy_std=zeros(1);
same_time_dif=zeros(1);

for i=1:length(files)
    fid=fopen(files(i).name);
    while ~feof(fid)
        str=fgets(fid);
        if str(1)=='/'
            template_filename=str(1:end-1);
        else
            test_filename=str(3:strfind(str,'.txt')+3);
            
            type=str(strfind(str,'.txt')+5:strfind(str,'.txt')+7);
            
            signature_1=importdata([data_path template_filename]);
            signature_2=importdata([data_path test_filename]);
            
            index1=strfind(template_filename,'/');
            signature_1_name=template_filename(index1(end)+1:strfind(template_filename,'.txt')-1);
            index2=strfind(test_filename,'/');
            signature_2_name=test_filename(index2(end)+1:strfind(test_filename,'.txt')-1);
            
            [sig_dis,path1,path2,dis_matrix,len,signature_1_speed,signature_2_speed,signature_1_dxdy,signature_2_dxdy]=DTWCompare(signature_1,signature_2);
            
            
            
            subplot(6,3,[1 2 4 5 7 8 10 11 13 14 16 17])
            plot(signature_1(:,1),signature_1(:,2),'r',signature_2(:,1),signature_2(:,2),'g');            
            legend(signature_1_name ,[signature_2_name ' ' type],'Location','NorthOutside');
            title(num2str(sig_dis));
            
            for i=1:30:len
                line([signature_1(path1(i),1) signature_2(path2(i),1)],[signature_1(path1(i),2) signature_2(path2(i),2)]);
            end
            
            subplot(6,3,3)
            plot(dis_matrix(sub2ind(size(dis_matrix),path1(1:len),path2(1:len))));            
            title('dis')
            
            subplot(6,3,6)
            plot(1:len,signature_1_speed(path1(1:len)),'r',1:len,signature_2_speed(path2(1:len)),'b');            
            title('speed')
                      
            subplot(6,3,9)
            plot(1:len,signature_1_dxdy(path1(1:len),1),'r',1:len,signature_2_dxdy(path2(1:len),1),'b');            
            title('dx')            
            
            subplot(6,3,12)
            plot(1:len,signature_1_dxdy(path1(1:len),2),'r',1:len,signature_2_dxdy(path2(1:len),2),'b');            
            title('dy')
            
            if size(signature_1,2)==4
                subplot(6,3,15)
                plot(1:len,signature_1(path1(1:len),4),'r',1:len,signature_2(path2(1:len),4),'b');
                title('pressure')

                subplot(6,3,18)
                pressure_time_1=zeros(length(signature_1),1);
                pressure_time_2=zeros(length(signature_2),1);
                pressure_time_1(2:end)=signature_1(2:end,4)./signature_1_speed(2:end);
                pressure_time_2(2:end)=signature_2(2:end,4)./signature_2_speed(2:end);
                plot(1:len,pressure_time_1(path1(1:len)),'r',1:len,pressure_time_2(path2(1:len)),'g');
                title('pressure_speed');
            end
                
            
            
                        title([signature_1_name ' ' signature_2_name '1.1-' type]);
            
                        legend(template_filename,test_filename);
            if strcmp(type,'0.1')
                dif_dis_std=[dif_dis_std std(dis_matrix(sub2ind(size(dis_matrix),path1(1:len),path2(1:len))))];
                dif_speed_std=[dif_speed_std std(signature_1_speed(path1(1:len))-signature_2_speed(path2(1:len)))];
                dif_dx_std=[dif_dx_std std(signature_1_dxdy(path1(1:len),1)-signature_2_dxdy(path2(1:len),1))];
                dif_dy_std=[dif_dy_std std(signature_1_dxdy(path1(1:len),2)-signature_2_dxdy(path2(1:len),2))];                
                cd('0.1')                
                print(gcf,'-dpng',[signature_1_name ' ' signature_2_name ' 1.1-' type '.png'])
                cd('..')
                
                dif_time_dif=[dif_time_dif length(signature_1)-length(signature_2)];
            else
                same_dis_std=[same_dis_std std(dis_matrix(sub2ind(size(dis_matrix),path1(1:len),path2(1:len))))];
                same_speed_std=[same_speed_std std(signature_1_speed(path1(1:len))-signature_2_speed(path2(1:len)))];
                same_dx_std=[same_dx_std std(signature_1_dxdy(path1(1:len),1)-signature_2_dxdy(path2(1:len),1))];
                same_dy_std=[same_dy_std std(signature_1_dxdy(path1(1:len),2)-signature_2_dxdy(path2(1:len),2))];                               
                cd('1.1')
                print(gcf,'-dpng',[signature_1_name ' ' signature_2_name ' 1.1-' type '.png'])
                cd('..')
                
                same_time_dif=[same_time_dif length(signature_1)-length(signature_2)];
            end
            
            
        end
    end
    fclose(fid);
end

dif_dis_std(1)=[];
dif_speed_std(1)=[];
dif_dx_std(1)=[];
dif_dy_std(1)=[];

same_dis_std(1)=[];
same_speed_std(1)=[];
same_dx_std(1)=[];
same_dy_std(1)=[];

dif_time_dif(1)=[];
same_time_dif(1)=[];



end

