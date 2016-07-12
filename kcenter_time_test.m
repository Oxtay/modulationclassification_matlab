

load kcenter_test_data

% randomly select an object as the initial point
Init = ceil(rand(1)*size(Data,1));
h = zeros(K,size(Data,2));
h(1,:) = Data(Init,:);

%% Second Scenario with bsxfun
dist = sum( (bsxfun(@minus, Data, h(1,:))).^2,2 );
cluster = ones(1,size(Data,1));

dist1=dist;
Hind=Init;
for i = 2:K
    dist1(Hind)=-1;
    D = max(dist1);
    ind = find(dist==D);
    Hind=[Hind,ind(1)];
    h(i,:) = Data(ind(1),:);
    distnew = sum( (bsxfun(@minus, Data, h(1,:))).^2,2 ); 
    cluster(distnew-dist<0)=i;
    dist(distnew-dist<0)=distnew(distnew-dist<0);
    dist1=dist;
end

