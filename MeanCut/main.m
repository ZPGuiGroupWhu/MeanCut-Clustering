%% Input the data
data = textread('ds1.txt');
[n,m] = size(data);
X = data(:,1:2);
ref = data(:,3);

%% Perform MeanCut algorithm
[cluster] = ImprovedMeanCut(X, 20, 0.2);

%% Visualize and evaluate the result
addpath ClusterEvaluation
plotcluster(X,cluster);
[ Accuracy, NMI, ARI, Fscore, JI, RI] = ClustEval(ref, cluster);


