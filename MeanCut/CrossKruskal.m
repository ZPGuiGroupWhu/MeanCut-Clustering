function [ ST, edgeW, dis ] = CrossKruskal(ne, w, cluster, dis)
    N    = max(ne(:));   % number of vertices
    Ne   = size(ne,1);   % number of edges    
    lidx = zeros(Ne,1);  % logical edge index; 1 for the edges that will be
                         % in the minimum spanning tree   
    % Sort edges w.r.t. weight
    visit = zeros(N,1);
    [w,idx] = sort(w); %%
    ne      = ne(idx,:);
    
    % Initialize: assign each node to itself
    [repr, rnk] = makeset(N);
    
    % Run Kruskal's algorithm
    for k = 1:Ne
        i = ne(k,1);
        j = ne(k,2);
        if fnd(i,repr) ~= fnd(j,repr)
            if (visit(i)==0&&visit(j)>0)
                clus = find(visit==visit(j));
                id1 = find(cluster==i);
                id2 = find(ismember(cluster,clus));
                visit(i) = visit(j);
            elseif(visit(j)==0&&visit(i)>0)
                clus = find(visit==visit(i));
                id1 = find(cluster==j);
                id2 = find(ismember(cluster,clus));
                visit(j) = visit(i);
            elseif(visit(i)>0&&visit(j)>0)
                clus1 = find(visit==visit(i));
                clus2 = find(visit==visit(j));
                id1 = find(ismember(cluster,clus1));
                id2 = find(ismember(cluster,clus2));
                visit(visit==visit(i)) = visit(j);
            else
                id1 = find(cluster==i);
                id2 = find(cluster==j);
                visit(i) = j;
                visit(j) = j;
            end
            dis(id1, id2) = w(k);
            dis(id2, id1) = w(k);
            lidx(k) = 1;
            [repr, rnk] = union(i, j, repr, rnk);
        end
    end
    
    % Form the minimum spanning tree
    
    ST      = ne(find(lidx),:);
    edgeW = w(find(lidx));
    % Generate adjacency matrix of the minimum spanning tree
end

function [repr, rnk] = makeset(N)
    repr = (1:N);
    rnk  = zeros(1,N);
end
function o = fnd(i,repr)
    while i ~= repr(i)
        i = repr(i);
    end
    o = i;
end
function [repr, rnk] = union(i, j, repr, rnk)
    r_i = fnd(i,repr);
    r_j = fnd(j,repr);
    if rnk(r_i) > rnk(r_j)
        repr(r_j) = r_i;
    else
        repr(r_i) = r_j;
        if rnk(r_i) == rnk(r_j)
            rnk(r_j) = rnk(r_j) + 1;
        end
    end
end