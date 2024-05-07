![image](https://img.shields.io/badge/MATLAB-R2023a-red)
# MeanCut: A Greedy-Optimized Graph Clustering via Path-based Similarity and Degree Descent Criterion


We propose a novel spectral clustering algorithm called MeanCut. It leverages the path-based similarity to enhance intra-cluster associations, and is optimized greedily in degree descending order for a nondestructive graph partition. This algorithm enables the identification of arbitrary shaped clusters and is robust to noise. To reduce the computational complexity of similarity calculation, we transform optimal path search into generating the maximum spanning tree (MST), and develop a fast MST (FastMST) algorithm to further improve its time-efficiency. Moreover, we define a density gradient factor (DGF) for separating the weakly connected clusters.

![image](https://github.com/ZPGuiGroupWhu/MeanCut-Clustering/blob/main/Pic/github.png)

# How To Run

Download the code and run the 'main' file in the 'MeanCut' file. ***To be noted, the Deep Learning Toolbox should be installed in MATLAB before running the application of Face Recognition.***

The 'meancut' function provides multiple hyperparameters for user configuration as follows 
```matlab
function [cluster] = meancut (X, varargin)
%   This is a novel spectal clustering algorithm based on path similarity and degree descent criterion. 
%   This function returns cluster labels of the N by D matrix X. Each row in X represents an observation.
% 
%   Parameters are: 
% 
%   'k1'           - A non-negative integer specifying the number of nearest neighbors for DGF. 
%                    It must be smaller than N.
%                    Default: 20
%   'k2'           - A non-negative integer specifying the number of nearest neighbors for MST. 
%                    It must be smaller than N.
%                    Default: 20
%   'ratio'        - A positive scalar in [0,1] specifying the percentile of the number of boudanry 
%                    points to the total number of points. 
%                    Default: 0
%   'Embed'        - Logical scalar. If true, project X with more than 5000 samples and 50 features
%                    into a lower-dimensional space. 
%                    Default: True
%   'Normalize'    - Logical scalar. If true, scale X using min-max normalization. If features in 
%                    X are on different scales, 'Normalize' should be set to true because the clustering 
%                    process is based on nearest neighbors and features with large scales can override 
%                    the contribution of features with small scales. 
%                    Default: True
%   'Noise'        - A non-negative integer specifying the threshold of a noisy cluster.
%                    Default: 0
%   'Kernel'       - Kernel function.
%                    Default: 'Laplacian'
%   'Bandwidth'    - A positive scalar specifying the bandwidth of the kernel function.
%                    Default: 2
```
# License

This project is covered under the Apache 2.0 License.
