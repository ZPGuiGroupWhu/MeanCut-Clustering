function [degs] = path_w(T)
%% Calculate the path-based similarity matrix

n = size(T.Nodes,1);
Edg = table2array(T.Edges);
[eW, idx] = sort(Edg(:,3),'descend'); 
od = Edg(idx,1:2);
visit = zeros(n,1);
degs = ones(n,1);
for k = 1:length(Edg)
    i = od(k,1);
    j = od(k,2);
    if(visit(i)==0 && visit(j)==0)
        degs(i) = degs(i) + eW(k);
        degs(j) = degs(j) + eW(k);
        visit(i) = j;
        visit(j) = j;
    elseif(visit(i)==0 && visit(j)~=0)
        set_id_j = find(visit==visit(j));
        degs(i) = degs(i) + length(set_id_j)*eW(k);
        degs(set_id_j) = degs(set_id_j) + eW(k);
        visit(i) = visit(j);
    elseif(visit(i)~=0 && visit(j)==0)
        set_id_i = find(visit==visit(i));
        degs(j) = degs(j) + length(set_id_i)*eW(k);
        degs(set_id_i) = degs(set_id_i) + eW(k);
        visit(j) = visit(i);
    else
        set_id_i = find(visit==visit(i));
        set_id_j = find(visit==visit(j));
        degs(set_id_i) = degs(set_id_i) + length(set_id_j)*eW(k);
        degs(set_id_j) = degs(set_id_j) + length(set_id_i)*eW(k);
        visit(set_id_j) = visit(i);
    end
end
end