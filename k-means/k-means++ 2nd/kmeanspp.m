function label = kmeanspp(X, k)
% X: d x n data matrix
% k: number of seeds
% reference: k-means++: the advantages of careful seeding. 
% by David Arthur and Sergei Vassilvitskii
% Written by Mo Chen (mochen@ie.cuhk.edu.hk). March 2009.
n = size(X,2);
last = 0;
label = softseeds(X, k);  % random initialization
while any(label ~= last)
    [~,~,label] = unique(label);   % remove empty clusters
    E = sparse(1:n,label,1,n,k,n);  % transform label into indicator matrix
    center = X*(E*spdiags(1./sum(E,1)',0,k,k));    % compute center of each cluster
    last = label;
    [~,label] = max(bsxfun(@minus,center'*X,0.5*sum(center.^2,1)')); % assign samples to the nearest centers
end
