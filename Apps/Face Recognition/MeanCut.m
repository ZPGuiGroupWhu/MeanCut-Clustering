function [cluster] = MeanCut(W,degs,T)
%% This is the parameter-free MeanCut algorithm
% W: the path-based similarity (weight) matrix
% degs: degree of all points
% T: the number of points that a non-noise cluster has at least
%%
n = length(W);
cluster = zeros(n,1);
mark = 1;
[deg_sort,ser] = sort(degs,'descend');
W_sort = W(ser,:);
W_sort = W_sort(:,ser);
while ismember(0,cluster)
    id = find(cluster==0,1);
    num = 1;
    sum_w = 1;
    sum_deg = deg_sort(id);
    meancut = (1/(n-1))*(1-sum_w/sum_deg);
    storage = id;
    for i = id+1:n
        if(cluster(i)==0)
            num = num + 1;
            sum_deg = sum_deg + deg_sort(i);
            sum_w = sum_w + 2*sum(W_sort(i,storage))+1;
            cut =  (1/(n-num))*(1-sum_w/sum_deg);
            if(cut <= meancut)
                meancut = cut;
                storage = [storage;i];
            else
                num = num - 1;
                sum_deg = sum_deg - deg_sort(i);
                sum_w = sum_w - 2*sum(W_sort(i,storage))-1;
            end
        end
    end
    cluster(storage) = mark;
    mark = mark + 1;
end
temp = sortrows([ser,cluster]);
cluster = temp(:,2);
for i=1:max(cluster)
    num = length(find(cluster==i));
    if(num<T)
        cluster(cluster==i) = 0;
    end
end
end