function [S, idx] = softseeds(X, k)
% X: d x n data matrix
% k: number of seeds
% reference: k-means++: the advantages of careful seeding. 
% by David Arthur and Sergei Vassilvitskii
% Written by Mo Chen (mochen@ie.cuhk.edu.hk). March 2009.
[d,n] = size(X);
idx = zeros(1,k);
S = zeros(d,k);
D = inf(1,n);
idx(1) = ceil(n.*rand);
% [dum idx(1)] = max(sum(X.^2,1));
S(:,1) = X(:,idx(1));
for i = 2:k
    D = min(D,sqdistance(S(:,i-1),X));
    idx(i) = discreternd(D/sum(D));
    S(:,i) = X(:,idx(i));
end