function  [ TrainArgument]=GetAllSignatureMahalanobisMartix(TaskArgument)
files=dir([TaskArgument.task_path,'/*.txt']);
a=randperm(length(files));
% TaskArgument.per=0.4;
train_number=1;
TrainSignature=cell(1,(TaskArgument.per*length(files))*5);
TrainSignatureName=cell(1,(TaskArgument.per*length(files))*5);
for i=1:length(files)
    
    if a(i)<=(TaskArgument.per*length(files))
        task_file=fopen([TaskArgument.task_path '/' files(i).name],'r');
        while ~feof(task_file)
            str=fgets(task_file);
            if ~isempty(strfind(str,'[TRAIN]'))
                train=true;
                test=false;
            elseif ~isempty(strfind(str,'[TEST]'))
                train=false;
                test=true;
                break;
            elseif str(1)=='['
                
            elseif train
                if TaskArgument.data_type==1
                    TrainSignature(train_number)={importdata([TaskArgument.data_path str(1:length(str)-2)])};
                elseif TaskArgument.data_type==2
                    [x,y,z,az,in,pps]=FPG_Signature_Read(str(1:strfind(str,'.fpg')+3),0,0);
                    temp_signature=zeros(length(x),6);
                    temp_signature(:,1)=x;
                    temp_signature(:,2)=y;
                    temp_signature(:,3)=1000/pps;
                    temp_signature(:,4)=z;
                    temp_signature(:,5)=az;
                    temp_signature(:,6)=in;
                    TrainSignature(train_number)={temp_signature};
                end
                TrainSignatureName(train_number)={str(1:length(str)-2)};
                train_number=train_number+1;
            elseif test
                
            end
        end
        fclose(task_file);
    end
end

% TrainArgument=TrainArgumentComputer(TrainSignature,TaskArgument);
dis_mat=zeros(length(TrainSignature));
TrainArgument.sum_hal_mat=zeros(length(TaskArgument.select_feature));
TrainArgument.optionfun=zeros(1,1+TaskArgument.iterations);


DTW_argument.normalization_type=TaskArgument.normalization_type;
DTW_argument.dis_type=TaskArgument.dis_type_1;
DTW_argument.dtw_type=TaskArgument.dtw_type;
DTW_argument.slope=TaskArgument.slope;
DTW_argument.distance=TaskArgument.distance;
% DTW_argument.hal_type=TaskArgument.hal_type;
DTW_argument.select_feature=TaskArgument.select_feature;


DTW_argument.Mahalanobis_Covariance_Matrix_inv=diag(ones(1,length(TaskArgument.select_feature)));
for i=1:length(TrainSignature)
    for j=i+1:length(TrainSignature)
        DTW_result=DTWCompare(cell2mat(TrainSignature(i)),cell2mat(TrainSignature(j)),DTW_argument);
        TrainArgument.sum_hal_mat=TrainArgument.sum_hal_mat+DTW_result.sum_mah_dis;
        TrainArgument.optionfun(1)=TrainArgument.optionfun(1)+DTW_result.optionfun;
    end
end

DTW_argument.dis_type=TaskArgument.dis_type_2;
for iter=1:TaskArgument.iterations
    TrainArgument.Mahalanobis_Covariance_Matrix_inv=inv(TrainArgument.sum_hal_mat)/(det(inv(TrainArgument.sum_hal_mat))^(1/(length(TaskArgument.select_feature))));
    DTW_argument.Mahalanobis_Covariance_Matrix_inv=TrainArgument.Mahalanobis_Covariance_Matrix_inv;
    for i=1:length(TrainSignature)
        for j=i+1:length(TrainSignature)
            DTW_result=DTWCompare(cell2mat(TrainSignature(i)),cell2mat(TrainSignature(j)),DTW_argument);
            dis_mat(i,j)=DTW_result.sig_dis;
            TrainArgument.sum_hal_mat=TrainArgument.sum_hal_mat+DTW_result.sum_mah_dis;
            TrainArgument.optionfun(iter+1)=TrainArgument.optionfun(iter+1)+DTW_result.optionfun;
        end
    end
end
