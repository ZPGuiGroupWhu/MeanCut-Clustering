function [ ST, edgeW, ConW ] = IntKruskal(ne, w)
    N    = max(ne(:));   % number of vertices
    Ne   = size(ne,1);   % number of edges    
    lidx = zeros(Ne,1);  % logical edge index; 1 for the edges that will be
                         % in the minimum spanning tree   
    % Sort edges w.r.t. weight
    visit = zeros(N,1);
    ConW = zeros(N,N);
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
                ConW(i,visit==visit(j)) = w(k);
                ConW(visit==visit(j),i) = w(k);
                visit(i) = visit(j);
            elseif(visit(j)==0&&visit(i)>0)
                ConW(j,visit==visit(i)) = w(k);
                ConW(visit==visit(i),j) = w(k);
                visit(j) = visit(i);
            elseif(visit(i)>0&&visit(j)>0)
                ConW(visit==visit(i),visit==visit(j)) = w(k);
                ConW(visit==visit(j),visit==visit(i)) = w(k);
                visit(visit==visit(i)) = visit(j);
            else
                ConW(i,j) = w(k);
                ConW(j,i) = w(k);
                visit(i) = j;
                visit(j) = j;
            end
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