function [cluster] = ImprovedMeanCut (X, knum, percentile, noiseT, ratio)
%% This is a novel spectal clustering algorithm based on path similarity and degree descent criterion
% X: input data with n samples
% knum: k of KNN
% percentile: the percentile of junction points (range:0-1)
% ratio: ratio of the DBSCAN Eps to the diagonal length of the maximum bounding rectangle (range:0-1)
% noiseT: the number of points that a non-noise cluster has at least
%%
if nargin==1
knum = 20;
percentile = 0.2;
noiseT = 0;
ratio = 0.2;
elseif nargin==2
percentile = 0.2;
noiseT = 0;
ratio = 0.2;
elseif nargin==3
noiseT = 0;
ratio = 0.2;
elseif nargin==4
ratio = 0.2;
end

n = length(X(:,1));
cluster = zeros(n,1);
[get_knn, knnDis] = knnsearch(X,X,'k',knum);
density = zeros(n,1);
grad = zeros(n,1);
for i=1:n
    density(i) = mean(knnDis(i,:));
end
for i=1:n
    id = find(knnDis(i,:)>0);
    grad(i) = 1./(knnDis(i,id))*(density(get_knn(i,id))-density(i));
end
grad_sort = sort(grad);
gradT = grad_sort(ceil(n*percentile)+1);
edg = find(grad<gradT);
int = find(grad>=gradT);
Y = X(int,:);
dis = FastMST(Y,ratio);
conW = exp(-0.5 * dis);
degs = sum(conW, 2);
int_clust = MeanCut(conW,degs,noiseT);
cluster(int) = int_clust;
near_int = knnsearch(X(int,:),X(edg,:));
cluster(edg) = int_clust(near_int);
end




