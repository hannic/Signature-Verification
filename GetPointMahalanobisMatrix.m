function GetPointMahalanobisMatrix(TrainSignature,TaskArgument,dtw_result_matrix)

longest_length=0;
for i=1:length(TrainSignature)
    temp_siganture=cell2mat(TrainSignature(i));
    if length(temp_signature)>longest_length
        longest_length=length(temp_signature);
    end
end
PointMahalanobisMatrix=zeros(longest_length,length(TaskArgument.select_feature),length(TaskArgument.select_feature))

for i=1:longest_length

