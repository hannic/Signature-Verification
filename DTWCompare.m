function [DTW_result]=DTWCompare(signature_1,signature_2,DTW_argument)
MAX_DIS_STR=999999;

signature_1_length=length(signature_1);
signature_2_length=length(signature_2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computer DTW distance matrix
DTW_result.dis_matrix=zeros(signature_1_length,signature_2_length);

switch DTW_argument.dis_type
    case 1
        for i=1:length(DTW_argument.DTW_feature)
            DTW_result.dis_matrix=DTW_result.dis_matrix+(repmat(signature_1(:,DTW_argument.DTW_feature(i)),1,signature_2_length)-...
                repmat(signature_2(:,DTW_argument.DTW_feature(i))',signature_1_length,1)).^2;
        end
        DTW_result.dis_matrix=DTW_result.dis_matrix.^0.5;
    case 2
        for i=1:signature_1_length
            temp_1=repmat(signature_1(i,DTW_argument.select_feature),signature_2_length,1)-signature_2(:,DTW_argument.select_feature);
            DTW_result.dis_matrix(i,:)=(sum((temp_1*DTW_argument.mahalanobis_covariance_matrix_inv).*temp_1,2)').^0.5;
        end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DTW_compare
qmax=DTW_argument.slope*signature_2_length/signature_1_length;
qmin=min(signature_2_length/(DTW_argument.slope*signature_1_length),1);

g=zeros(signature_1_length,signature_2_length);
g(:)=MAX_DIS_STR;
h=zeros(signature_1_length,signature_2_length);
g(1,1)=DTW_result.dis_matrix(1,1);
g(1,2)=DTW_result.dis_matrix(1,2);
g(1,3)=DTW_result.dis_matrix(1,2)+DTW_result.dis_matrix(1,3);
g(1,4)=DTW_result.dis_matrix(1,3)+DTW_result.dis_matrix(1,4);
h(1,2:4)=1;

switch DTW_argument.dtw_type
    case 1
        for i=2:signature_1_length
            minJ=floor(max((i-1)*qmin,signature_2_length-1+qmax*((i-1)-signature_1_length+1)))+1;
            maxJ=floor(min((i-1)*qmax,signature_2_length-1+qmin*((i-1)-signature_1_length+1)))+1;
            for j=minJ:maxJ
                min_temp=MAX_DIS_STR;
                minID=-1;
                if j>=2 &&  j>minJ && min_temp>g(i,j-1)+DTW_argument.gamma
                    minID=1;
                    min_temp=g(i,j-1)+DTW_argument.gamma;
                end
                if j>=2 && min_temp> g(i-1,j-1)+DTW_result.dis_matrix(i,j)
                    minID=2;
                    min_temp=g(i-1,j-1)+DTW_result.dis_matrix(i,j);
                end
                if min_temp > g(i-1,j)+DTW_argument.gamma
                    minID=3;
                    min_temp=g(i-1,j)+DTW_argument.gamma;
                end
                g(i,j)=min_temp;
                h(i,j)=minID;
            end
        end
    case 2
        for i=2:signature_1_length
            minJ=floor(max((i-1)*qmin,signature_2_length-1+qmax*((i-1)-signature_1_length+1)))+1;
            maxJ=floor(min((i-1)*qmax,signature_2_length-1+qmin*((i-1)-signature_1_length+1)))+1;
            for j=minJ:maxJ
                min_temp=MAX_DIS_STR;
                minID=-1;
                if j>=2 &&  j>minJ && min_temp>g(i,j-1)+DTW_result.dis_matrix(i,j)
                    minID=1;
                    min_temp=g(i,j-1)+DTW_result.dis_matrix(i,j);
                end
                if j>=2 && min_temp> g(i-1,j-1)+DTW_result.dis_matrix(i,j)
                    minID=2;
                    min_temp=g(i-1,j-1)+DTW_result.dis_matrix(i,j);
                end
                if min_temp > g(i-1,j)+DTW_result.dis_matrix(i,j)
                    minID=3;
                    min_temp=g(i-1,j)+DTW_result.dis_matrix(i,j);
                end
                g(i,j)=min_temp;
                h(i,j)=minID;
            end
        end
    case 3
        weigthPath=cell2mat(DTW_argument.TrainSignatureWeigthPath_1(DTW_argument.trainSignature_index));
        g(1,1)=weigthPath(1)*DTW_result.dis_matrix(1,1);
        g(1,2)=weigthPath(2)*DTW_result.dis_matrix(1,2);
        g(1,3)=weigthPath(2)*DTW_result.dis_matrix(1,2)+weigthPath(3)*DTW_result.dis_matrix(1,3);
        g(1,4)=weigthPath(3)*DTW_result.dis_matrix(1,3)+weigthPath(4)*DTW_result.dis_matrix(1,4);
        h(1,2:4)=1;
        for i=2:signature_1_length
            minJ=floor(max((i-1)*qmin,signature_2_length-1+qmax*((i-1)-signature_1_length+1)))+1;
            maxJ=floor(min((i-1)*qmax,signature_2_length-1+qmin*((i-1)-signature_1_length+1)))+1;
            for j=minJ:maxJ
                min_temp=MAX_DIS_STR;
                minID=-1;
                if j>=2 &&  j>minJ && min_temp>g(i,j-1)+weigthPath(j)*DTW_result.dis_matrix(i,j)
                    minID=1;
                    min_temp=g(i,j-1)+weigthPath(j)*DTW_result.dis_matrix(i,j);
                end
                if j>=2 && min_temp> g(i-1,j-1)+weigthPath(j)*DTW_result.dis_matrix(i,j)
                    minID=2;
                    min_temp=g(i-1,j-1)+weigthPath(j)*DTW_result.dis_matrix(i,j);
                end
                if min_temp > g(i-1,j)+weigthPath(j)*DTW_result.dis_matrix(i,j)
                    minID=3;
                    min_temp=g(i-1,j)+weigthPath(j)*DTW_result.dis_matrix(i,j);
                end
                g(i,j)=min_temp;
                h(i,j)=minID;
            end
        end
    case 4
        segmentVector=cell2mat(DTW_argument.allsegmentResult(DTW_argument.trainSignature_index));
        phaseWeghit_=cell2mat(DTW_argument.TrainSignaturePhaseWeigth);
        phaseWeghit=phaseWeghit_.phaseWeightNor;
        
%         g(1,1)=phaseWeghit(1)*DTW_result.dis_matrix(1,1);
%         g(1,2)=phaseWeghit(1)*DTW_result.dis_matrix(1,2);
%         g(1,3)=phaseWeghit(1)*DTW_result.dis_matrix(1,2)+phaseWeghit(1)*DTW_result.dis_matrix(1,3);
%         g(1,4)=phaseWeghit(1)*DTW_result.dis_matrix(1,3)+phaseWeghit(1)*DTW_result.dis_matrix(1,4);

        for i=2:signature_1_length
            minJ=floor(max((i-1)*qmin,signature_2_length-1+qmax*((i-1)-signature_1_length+1)))+1;
            maxJ=floor(min((i-1)*qmax,signature_2_length-1+qmin*((i-1)-signature_1_length+1)))+1;                    
            for j=minJ:maxJ
                if j<=segmentVector(1)
                    weight=phaseWeghit(1);
                else
                    for index_1=2:length(segmentVector)
                        if j<=segmentVector(index_1)&&j>segmentVector(index_1-1);
                            weight=phaseWeghit(index_1);
                            break;
                        end
                    end
                end
            
                min_temp=MAX_DIS_STR;
                minID=-1;
                if j>=2 &&  j>minJ && min_temp>g(i,j-1)+weight*DTW_result.dis_matrix(i,j)
                    minID=1;
                    min_temp=g(i,j-1)+weight*DTW_result.dis_matrix(i,j);
                end
                if j>=2 && min_temp> g(i-1,j-1)+weight*DTW_result.dis_matrix(i,j)
                    minID=2;
                    min_temp=g(i-1,j-1)+weight*DTW_result.dis_matrix(i,j);
                end
                if min_temp > g(i-1,j)+weight*DTW_result.dis_matrix(i,j)
                    minID=3;
                    min_temp=g(i-1,j)+weight*DTW_result.dis_matrix(i,j);
                end
                g(i,j)=min_temp;
                h(i,j)=minID;
            end
        end
end
%compute the DTW length

DTW_result.len=1;
while i>1 || j>1
    switch h(i,j)
        case 1
            j=j-1;
            DTW_result.len=DTW_result.len+1;
        case 2
            j=j-1;
            i=i-1;
            DTW_result.len=DTW_result.len+1;
        case 3
            i=i-1;
            DTW_result.len=DTW_result.len+1;
    end
end

%generate the signature_1 and signature_2 DTW path
k=DTW_result.len;
DTW_result.path1=zeros(1,2*max(signature_1_length,signature_2_length));
DTW_result.path2=zeros(1,2*max(signature_1_length,signature_2_length));
i=signature_1_length;
j=signature_2_length;
while i>1 || j>1
    DTW_result.path1(k)=i;
    DTW_result.path2(k)=j;
    k=k-1;
    switch h(i,j)
        case 1
            j=j-1;
        case 2
            j=j-1;
            i=i-1;
        case 3
            i=i-1;
    end
end
DTW_result.path1(1)=1;
DTW_result.path2(1)=1;
DTW_result.g=g;
DTW_result.distance=g(end);
DTW_result.mean_distance_len=g(end)/DTW_result.len;
DTW_result.mean_distance_sum_len=g(end)/(signature_1_length+signature_2_length);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if DTW_argument.distance==2
    DTW_result.optionfun=0;
    DTW_result.sum_mah_dis=zeros(length(DTW_argument.select_feature));
    for i=1:DTW_result.len
        temp_vec=(signature_1(DTW_result.path1(i),DTW_argument.select_feature)-signature_2(DTW_result.path2(i),DTW_argument.select_feature));
        DTW_result.optionfun=DTW_result.optionfun+temp_vec*DTW_argument.mahalanobis_covariance_matrix_inv*temp_vec';
        DTW_result.sum_mah_dis=DTW_result.sum_mah_dis+temp_vec'*temp_vec;
    end
end

end
