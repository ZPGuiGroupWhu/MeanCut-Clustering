function [dis,clus_num] = FastMST(X,ratio)
%% This is the fast maximum spanning tree algorithm
% X: all points
% ratio: ratio of the DBSCAN Eps to the diagonal length of the maximum bounding rectangle (range:0-1)
%%

[n, ~] = size(X);
eps = ratio*sqrt((max(X)-min(X))*(max(X)-min(X))');
cluster = dbscan(X, eps, 1);
clus_num = max(cluster);
dis = pdist2(X,X);
maxD = max(max(dis))+1;
amat = maxD*tril(ones(n));
D = dis-amat;

for i=1:clus_num
    id = find(cluster==i);
    num = length(id);
    if(num>2)
        tempD = D(id,id);
        [row, col] = find(tempD<=eps & tempD>=0);
        pts = [row, col];      
        edges = tempD((col-1)*num+row);
        [~,~,subW] = IntKruskal(pts, edges);
        dis(id,id) = subW;
    end
end

if(clus_num > 1)
    [row, col] = find(D>eps);
    row = cluster(row);
    col = cluster(col);
    pts = [row, col];
    edges = D(D>eps);
    [~,~,dis] = CrossKruskal(pts, edges, cluster, dis);
end
