% [dif_dis_std,dif_speed_std,dif_dx_std,dif_dy_std,same_dis_std,same_speed_std,same_dx_std,same_dy_std dif_time_dif same_time_dif]=analy('/home/ksl/ESRA_dev/result/partition-DS2-50-1_1');
% [dif_dis_std_1,dif_speed_std_1,dif_dx_std_1,dif_dy_std_1,same_dis_std_1,same_speed_std_1,same_dx_std_1,same_dy_std_1 dif_time_dif_1 same_time_dif_1]=analy('/home/ksl/ESRA_dev/result/partition-DS2-50-1_2');
subplot(4,2,1)
plot(1:length(dif_dis_std),dif_dis_std,'r',1:length(same_dis_std),same_dis_std,'g')
legend('worry','right');
title('dis')
subplot(4,2,3)
plot(1:length(dif_speed_std),dif_speed_std,'r',1:length(same_speed_std),same_speed_std,'g')
legend('worry','right');
title('speed')
subplot(4,2,5)
plot(1:length(dif_dx_std),dif_dx_std,'r',1:length(same_dx_std),same_dx_std,'g')
legend('worry','right');
title('dx')
subplot(4,2,7)
plot(1:length(dif_dy_std),dif_dy_std,'r',1:length(same_dy_std),same_dy_std,'g')
legend('worry','right');
title('dy')


subplot(4,2,2)
plot(1:length(dif_dis_std_1),dif_dis_std_1,'r',1:length(same_dis_std_1),same_dis_std_1,'g')
legend('worry','right');
title('dis')
subplot(4,2,4)
plot(1:length(dif_speed_std_1),dif_speed_std_1,'r',1:length(same_speed_std_1),same_speed_std_1,'g')
legend('worry','right');
title('speed')
subplot(4,2,6)
plot(1:length(dif_dx_std_1),dif_dx_std_1,'r',1:length(same_dx_std_1),same_dx_std_1,'g')
legend('worry','right');
title('dx')
subplot(4,2,8)
plot(1:length(dif_dy_std_1),dif_dy_std_1,'r',1:length(same_dy_std_1),same_dy_std_1,'g')
legend('worry','right');
title('dy')

% subplot(1,2,1)
