function [cluster,h]=KCenterClustering(Data,K)
% Data is the whole dataset, the row is set of the data, the column is the variable in one data vector 
% K is the cluster number

% Using Greedy Algorithm for K-center clustering, the distance measure is
% the euclidean distance

% Xiaoqiang Xiao
% Penn State University, 9/28/07

% randomly select an object as the initial point
Init = ceil(rand(1)*size(Data,1));
h = zeros(K,size(Data,2));
h(1,:) = Data(Init,:);

% for j = 1:size(Data,1)
%     dist(j) = sum( (Data(j,:)-h(1,:)).^2 );
%     cluster(j) = 1;
% end

dist = sum( (Data-repmat(h(1,:),[size(Data,1),1])),2 );
cluster = ones(1,size(Data,1));

dist1=dist;
Hind=Init;
for i = 2:K
    dist1(Hind)=-1;
    D = max(dist1);
    ind = find(dist==D);
    Hind=[Hind,ind(1)];
    h(i,:) = Data(ind(1),:);
%     for j = 1:n
%         if sum( (Data(j,:)-h(i,:)).^2 ) < dist(j)
%             dist(j) = sum( (Data(j,:)-h(i,:)).^2 );
%             dist1(j) = sum( (Data(j,:)-h(i,:)).^2 );
%             cluster(j)=i;
%         end
%     end
    distnew = sum( (Data-repmat(h(i,:),[size(Data,1),1])),2 ); 
    cluster(distnew-dist<0)=i;
    dist(distnew-dist<0)=distnew(distnew-dist<0);
    dist1=dist;
end

