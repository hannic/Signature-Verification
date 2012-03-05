function TrainSignatureWeigthPath=ComputeLocalWeight(TrainSignature,dtw_result_matrix,distance_matrix,TaskArgument,TrainArgument)
template_index=find(sum(distance_matrix)==min(sum(distance_matrix)));
train_signature=zeros(5,length(cell2mat(TrainSignature(template_index))));
path_signature=zeros(5,length(cell2mat(TrainSignature(template_index))));

if template_index<5
    for i=1:5
        if i~=template_index
            dtw_result=cell2mat(dtw_result_matrix(template_index,i));
            signature_1=cell2mat(TrainSignature(template_index));
            signature_2=cell2mat(TrainSignature(i));
            if i<template_index
                for index=1:dtw_result.len
                    train_signature(i,dtw_result.path2(index))=train_signature(i,dtw_result.path2(index))+...
                        signature_1(dtw_result.path1(index),TaskArgument.select_feature)*...
                        TrainArgument.mahalanobis_covariance_matrix_inv*signature_1(dtw_result.path1(index),TaskArgument.select_feature)';
                    
                    path_signature(i,dtw_result.path2(index))=path_signature(i,dtw_result.path2(index))+1;
                end
            elseif i>template_index
                for index=1:dtw_result.len
                    train_signature(i,dtw_result.path1(index))=train_signature(i,dtw_result.path1(index))+signature_2(dtw_result.path2(index),TaskArgument.select_feature)*...
                        TrainArgument.mahalanobis_covariance_matrix_inv*signature_2(dtw_result.path2(index),TaskArgument.select_feature)';
                    
                    path_signature(i,dtw_result.path1(index))=path_signature(i,dtw_result.path1(index))+1;
                end
            end
            for index=1:length(cell2mat(TrainSignature(template_index)))
                if path_signature(i,index)~=0
                    train_signature(i,index)=train_signature(i,index)/path_signature(i,index);
                end
            end
        elseif i==template_index
            dtw_result=cell2mat(dtw_result_matrix(template_index,i+1));
            for index=1:length(cell2mat(TrainSignature(template_index)))
                train_signature(i,index)= signature_1(index,TaskArgument.select_feature)*TrainArgument.mahalanobis_covariance_matrix_inv*signature_1(index,TaskArgument.select_feature)';
            end
        end
    end
elseif template_index==5
    for i=1:5
        if i~=template_index;
            dtw_result=cell2mat(dtw_result_matrix(i,5));
            signature_1=cell2mat(TrainSignature(i));
            signature_2=cell2mat(TrainSignature(5));
            for index=1:dtw_result.len
                train_signature(i,dtw_result.path2(index))=train_signature(i,dtw_result.path2(index))+signature_1(dtw_result.path1(index),TaskArgument.select_feature)*...
                    TrainArgument.mahalanobis_covariance_matrix_inv*signature_1(dtw_result.path1(index),TaskArgument.select_feature)';
                
                path_signature(i,dtw_result.path2(index))=path_signature(i,dtw_result.path2(index))+1;
            end
            for index=1:length(cell2mat(TrainSignature(template_index)))
                if path_signature(i,index)~=0
                    train_signature(i,index)=train_signature(i,index)/path_signature(i,index);
                end
            end
            
        elseif i==5;
            dtw_result=cell2mat(dtw_result_matrix(1,5));
            signature_1=cell2mat(TrainSignature(1));
            signature_2=cell2mat(TrainSignature(5));
            for index=1:length(cell2mat(TrainSignature(template_index)))
                train_signature(i,index)= signature_2(index,TaskArgument.select_feature)*TrainArgument.mahalanobis_covariance_matrix_inv*signature_2(index,TaskArgument.select_feature)';
            end
        end
    end
end

weigth_path=std(train_signature);


TrainSignatureWeigthPath={};

if template_index<5
    for i=1:5
        temp_weigth_path=zeros(1,length(cell2mat(TrainSignature(i))));
        temp_weigth_num=zeros(1,length(cell2mat(TrainSignature(i))));
        if i~=template_index
            if i<template_index
                dtw_result=cell2mat(dtw_result_matrix(template_index,i));
                signature_1=cell2mat(TrainSignature(template_index));
                signature_2=cell2mat(TrainSignature(i));
                for index=1:dtw_result.len
                    temp_weigth_path(dtw_result.path1(index))=temp_weigth_path(dtw_result.path1(index))+weigth_path(dtw_result.path2(index));
                    temp_weigth_num(dtw_result.path1(index))=temp_weigth_num(dtw_result.path1(index))+1;
                end
            elseif i>template_index
                dtw_result=cell2mat(dtw_result_matrix(template_index,i));
                for index=1:dtw_result.len
                    temp_weigth_path(dtw_result.path2(index))=temp_weigth_path(dtw_result.path2(index))+weigth_path(dtw_result.path1(index));
                    temp_weigth_num(dtw_result.path2(index))=temp_weigth_num(dtw_result.path2(index))+1;
                end
            end
            for index=1:length(cell2mat(TrainSignature(i)))
                if temp_weigth_num(index)~=0
                    temp_weigth_path(index)=temp_weigth_path(index)/temp_weigth_num(index);
                end
            end
        else
            temp_weigth_path= weigth_path;
        end
        TrainSignatureWeigthPath=[TrainSignatureWeigthPath,temp_weigth_path];
    end
elseif template_index==5
    for i=1:5
        temp_weigth_path=zeros(1,length(cell2mat(TrainSignature(i))));
        temp_weigth_num=zeros(1,length(cell2mat(TrainSignature(i))));
        if i~=template_index
            dtw_result=cell2mat(dtw_result_matrix(template_index,i));
            signature_1=cell2mat(TrainSignature(template_index));
            signature_2=cell2mat(TrainSignature(i));
            for index=1:dtw_result.len
                temp_weigth_path(dtw_result.path1(index))=temp_weigth_path(dtw_result.path1(index))+weigth_path(dtw_result.path2(index));
                temp_weigth_num(dtw_result.path1(index))=temp_weigth_num(dtw_result.path1(index))+1;
            end
            for index=1:length(cell2mat(TrainSignature(i)))
                if temp_weigth_num(index)~=0
                    temp_weigth_path(index)=temp_weigth_path(index)/temp_weigth_num(index);
                end
            end
        else
            temp_weigth_path= weigth_path;
        end
        TrainSignatureWeigthPath=[TrainSignatureWeigthPath,temp_weigth_path];
    end
end












