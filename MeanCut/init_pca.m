function xx = init_pca(X, no_dims, contri)
% This function preprocesses data with excessive size and dimensions.
%
%   Parameters are:
%
%   'X'       - N by D matrix. Each row in X represents an observation.
%   'no_dims' - A positive integer specifying the number of dimension of the representation Y. 
%   'contri'  - Threshold of PCA variance contribution.

[~, m] = size(X);

% Make sure data is zero mean
mapping.mean = mean(X, 1);
X = bsxfun(@minus, X, mapping.mean);

C = cov(X);

% Perform eigendecomposition of C
C(isnan(C)) = 0;
C(isinf(C)) = 0;
[M, lambda] = eig(C);

% Sort eigenvectors in descending order
[lambda, ind] = sort(diag(lambda), 'descend');

% Obtain the best PCA dimension
idx = cumsum(lambda)/sum(lambda) < contri;
if max(idx)==0
    bestDim = no_dims;
else
    bestDim = max(no_dims, min(find(idx, 1, 'last' ),2000));
end

% Apply mapping on the data
xx = X*M(:,ind(1:bestDim));  