function T = FastMST(X, G, kernel, delta)
%% Fast approximate maximum spanning tree algorithm

cluster = conncomp(G);
clus_num = length(unique(cluster));
all_id = 1:size(X, 1);
if(clus_num >= 2)
    for i=1:clus_num-1
        clus_id = find(cluster==i);
        rest_id = setdiff(all_id, clus_id);
        [pt_id, near_dis] = knnsearch(X(rest_id,:),X(clus_id,:));
        near_id = find(near_dis==min(near_dis));
        G = addedge(G,clus_id(near_id),rest_id(pt_id(near_id)),min(near_dis));
        all_id = rest_id;
    end
end

[T, ~] = minspantree(G,'Type','forest','Method','sparse');
if(strcmpi(kernel,'Laplacian'))
    T.Edges.Weight = exp(-T.Edges.Weight./delta);
elseif(strcmpi(kernel,'Gaussian'))
    T.Edges.Weight = exp(-(T.Edges.Weight).^2./(2*delta.^2));
end

% Edg = table2array(T.Edges);
% for i=1:length(Edg)
%     plot(X([Edg(i,1),Edg(i,2)],1),X([Edg(i,1),Edg(i,2)],2),'k-','LineWidth',1)
%     hold on;
% end
% plot(X(:,1),X(:,2),'o','markerfacecolor',[31,119,179]/255,'markeredgecolor',[31,119,179]/255,'markersize',5);
% hold on;
% axis off;




