load PSK8
K=8;
Data = [real(y_chann), imag(y_chann)];
[IDX, C] = kmeans(Data, K);
% figure,
% plot(Data(:,1),Data(:,2),'.');
% hold on, plot(C(:,1),C(:,2),'r+');

[cluster,h]=KCenterClustering(Data,K);
% figure,
% plot(Data(:,1),Data(:,2),'.');
% hold on, plot(h(:,1),h(:,2),'r+');

[IDX1, C1] = kmeans(Data, K, 'Start', h);
figure,
plot(Data(:,1),Data(:,2),'.');
hold on, plot(C1(:,1),C1(:,2),'r+');


load QAM16
K=16;
Data = [real(y_chann), imag(y_chann)];
[IDX, C] = kmeans(Data, K);
% figure,
% plot(Data(:,1),Data(:,2),'.');
% hold on, plot(C(:,1),C(:,2),'r+');

[cluster,h]=KCenterClustering(Data,K);
% figure,
% plot(Data(:,1),Data(:,2),'.');
% hold on, plot(h(:,1),h(:,2),'r+');

[IDX1, C1] = kmeans(Data, K, 'Start', h);
figure,
plot(Data(:,1),Data(:,2),'.');
hold on, plot(C1(:,1),C1(:,2),'r+');
