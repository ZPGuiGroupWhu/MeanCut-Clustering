function [pW] = path_w1(T)
%% Calculate the path-based similarity matrix

n = size(T.Nodes,1);
Edg = table2array(T.Edges);
[eW, idx] = sort(Edg(:,3),'descend'); 
od = Edg(idx,1:2);
visit = zeros(n,1);
pW = single(zeros(n,n));
pW = pW + eye(size(pW));
for k = 1:size(Edg,1)
    i = od(k,1);
    j = od(k,2);
    if(visit(i)==0 && visit(j)==0)
        pW(i,j) = eW(k);
        pW(j,i) = eW(k);
        visit(i) = j;
        visit(j) = j;
    elseif(visit(i)==0 && visit(j)~=0)
        set_id_j = find(visit==visit(j));
        pW(i,set_id_j) = eW(k);
        pW(set_id_j,i) = eW(k);
        visit(i) = visit(j);
    elseif(visit(i)~=0 && visit(j)==0)
        set_id_i = find(visit==visit(i));
        pW(set_id_i,j) = eW(k);
        pW(j,set_id_i) = eW(k);
        visit(j) = visit(i);
    else
        set_id_i = find(visit==visit(i));
        set_id_j = find(visit==visit(j));
        pW(set_id_i,set_id_j) = eW(k);
        pW(set_id_j,set_id_i) = eW(k);
        visit(set_id_j) = visit(i);
    end
end
end