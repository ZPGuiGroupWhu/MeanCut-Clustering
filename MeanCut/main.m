% Input the data
clear;
data = textread('Synthetic Datasets\DS1.txt');
[~, m] = size(data);
X = data(:, 1:m-1);
ref = data(:, m);

% Perform the MeanCut algorithm
% DS6, DS7, DS8: k1 = 20; ratio=0.2, 0.7, 0.3;
cluster = meancut(X);

% Evaluate the clustering accuracy
addpath ClusterEvaluation
[ACC, NMI, ARI, Fscore, JI, RI] = ClustEval(ref, cluster);

% Plot the clustering results
plotcluster2(X, cluster);
