![image](https://img.shields.io/badge/MATLAB-R2020b-red)
# MeanCut: A Greedy-Optimized Graph Clustering via Path-based Similarity and Degree Descent Criterion


We propose a novel spectral clustering algorithm called MeanCut. It leverages the path-based similarity to enhance intra-cluster associations, and is optimized greedily in degree descending order for a nondestructive graph partition. This algorithm enables the identification of arbitrary shaped clusters and is robust to noise. To reduce the computational complexity of similarity calculation, we transform optimal path search into generating the maximum spanning tree (MST), and develop a fast MST (FastMST) algorithm to further improve its time-efficiency. Moreover, we define a density gradient factor (DGF) for separating the weakly connected clusters.

![image](https://github.com/ZPGuiGroupWhu/MeanCut-Clustering/blob/main/pics/github.jpg)

# How To Run

Download the code and run the 'main' file in the root directory.***In addition, we provide two use cases, i.e., UCI Cluster and Face Recognition. The corresponding code and sample datasets are included in the Apps folder. To be noted, the Deep Learning Toolbox should be installed in MATLAB before running the application of Face Recognition.***

```ruby
%% Input the data
data = textread('Synthetic Datasets/DS1.txt');
[n,m] = size(data);
X = data(:,1:2);
ref = data(:,3);

%% Perform MeanCut algorithm
% DS1,DS2,DS3: knum = 20; percentile = 0; noiseT = 0;
% DS4: knum = 20; percentile = 0; noiseT = 20;
% DS5: knum = 20; percentile = 0; noiseT = 50;
% DS6: knum = 20; percentile = 0.7; noiseT = 0;
% DS7: knum = 20; percentile = 0.8; noiseT = 0;
% DS8: knum = 20; percentile = 0.7; noiseT = 0;
% DS9: knum = 20; percentile = 0.3; noiseT = 0;
knum = 20;
percentile = 0;
noiseT = 0;
[cluster] = ImprovedMeanCut(X, knum, percentile, noiseT);

%% Visualize and evaluate the result
addpath ClusterEvaluation
plotcluster(X,cluster);
[ Accuracy, NMI, ARI, Fscore, JI, RI] = ClustEval(ref, cluster);

```
# License

This project is covered under the Apache 2.0 License.
