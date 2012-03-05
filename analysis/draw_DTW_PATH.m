function draw_DTW_PATH(signature_1_name,signature_2_name,TaskArgument,step)
signature_1=Signature_Read(signature_1_name,TaskArgument);
signature_2=Signature_Read(signature_2_name,TaskArgument);
DTW_result=DTWCompare(signature_1,signature_2,TaskArgument);



plot(signature_1(:,1),signature_1(:,2),'r',signature_2(:,1),signature_2(:,2),'b');
hold on
for j=1:step:DTW_result.len
    line([signature_1(DTW_result.path1(j),1) signature_2(DTW_result.path2(j),1)],...
        [signature_1(DTW_result.path1(j),2) signature_2(DTW_result.path2(j),2)],'LineStyle','--','Color','k');
end
    
        
        
               
        
        
        




 