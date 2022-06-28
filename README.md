![image](https://img.shields.io/badge/MATLAB-R2020b-red)
# MeanCut: A Greedy-Optimized Graph Clustering via Path-based Similarity and Degree Descent Criterion


We propose a novel spectral clustering algorithm called MeanCut. It leverages the path-based similarity to enhance intra-cluster associations, and is optimized greedily in degree descending order for a nondestructive graph partition. This algorithm enables the identification of arbitrary shaped clusters and is robust to noise. To reduce the computational complexity of similarity calculation, we transform optimal path search into generating the maximum spanning tree (MST), and develop a fast MST (FastMST) algorithm to further improve its time-efficiency. Moreover, we define a density gradient factor (DGF) for separating the weakly connected clusters.

# How To Run

Download the code and run the 'main' file in the root directory.

```ruby
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

```
