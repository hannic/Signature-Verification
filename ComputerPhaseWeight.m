function result=ComputerPhaseWeight(templateNum,dtw_result_matrix,segmentResult,TaskArgument)

if strcmp(TaskArgument.keyPointMethod,'random')
else
    segment_result=cell2mat(segmentResult);
    phaseNum=length(segment_result.KeyPoint);
    KeyPointVector=segment_result.KeyPoint;
    phase=zeros(phaseNum,4);
    phaseWeight=zeros(phaseNum,1);
    for i=1:phaseNum
        num=1;
        for j=1:5
            if j<templateNum
                DTW_result=cell2mat(dtw_result_matrix(j,templateNum));
                index=find(DTW_result.path2==KeyPointVector(i),1,'last');
                if i>1
                    before_index=find(DTW_result.path2==KeyPointVector(i-1),1,'last');
                    temp=DTW_result.g(DTW_result.path1(index),DTW_result.path2(index))-DTW_result.g(DTW_result.path1(before_index),DTW_result.path2(before_index));
                    temp=temp/(KeyPointVector(i)-KeyPointVector(i-1));
                else
                    temp=DTW_result.g(DTW_result.path1(index),DTW_result.path2(index));
                    temp=temp/KeyPointVector(i);
                end
            elseif j>templateNum
                DTW_result=cell2mat(dtw_result_matrix(templateNum,j));
                index=find(DTW_result.path1==KeyPointVector(i),1,'last');
                if i>1
                    before_index=find(DTW_result.path1==KeyPointVector(i-1),1,'last');
                    temp=DTW_result.g(DTW_result.path1(index),DTW_result.path2(index))-DTW_result.g(DTW_result.path1(before_index),DTW_result.path2(before_index));
                    temp=temp/(KeyPointVector(i)-KeyPointVector(i-1));
                else
                    temp=DTW_result.g(DTW_result.path1(index),DTW_result.path2(index));
                    temp=temp/KeyPointVector(i);
                end
            end
            if j~=templateNum
                phase(i,num)=temp;
                num=num+1;
            end
        end
    end
    if TaskArgument.phaseWeightmethod==1
        phaseWeight=sum(phase,2);
    elseif TaskArgument.phaseWeightmethod==2
        phaseWeight=std(phase,0,2);
    elseif TaskArgument.phaseWeightmethod==3
        phaseWeight=sum(phase,2).*std(phase,0,2);
    elseif TaskArgument.phaseWeightmethod==4
        temp_phase=zeros(size(phase));
        temp_phase=(repmat(sum(phase),size(phase,1),1)./phase)./repmat(sum((repmat(sum(phase),size(phase,1),1)./phase)),size(phase,1),1);
        temp_weghit=(repmat(sum(phase,2),1,size(phase,2))./phase)./repmat(sum((repmat(sum(phase,2),1,size(phase,2))./phase),2),1,size(phase,2));
        phaseWeight=sum(temp_phase.*temp_weghit,2);
    elseif TaskArgument.phaseWeightmethod==5
        
    end
end
result.phaseWeightNor=(sum(phaseWeight)./phaseWeight)/sum(sum(phaseWeight)./phaseWeight);
% result.phaseWeightNor=ones(size(result.phaseWeightNor));
result.phaseWeightNor=result.phaseWeightNor/(1/length(KeyPointVector));
end
