function [cluster] = degree_descent1(W,noiseT)
%% Greedy optimization with degree descent criterion algorithm

n = size(W,1);
cluster = zeros(n,1);
mark = 1;
degs = sum(W,2);
[deg_sort,sort_id] = sort(degs,'descend');
W_sort = W(sort_id,:);
W_sort = W_sort(:,sort_id);
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
temp = sortrows([sort_id,cluster]);
cluster = temp(:,2);
mark = 1;
for i=1:max(cluster)
    num = length(find(cluster==i));
    if(num<noiseT)
        cluster(cluster==i) = 0;
    else
        cluster(cluster==i) = mark;
        mark = mark + 1;
    end
end
end