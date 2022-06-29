%% Input the UCI datasets
data = csvread('UCI Datasets/Iris.csv');
[n,m] = size(data);
X = data(:,1:m-1);
ref = data(:,m);

%% Normalize data using max-min function
for i=1:length(X(1,:))
    if((max(X(:,i))-min(X(:,i)))>0)
        X(:,i) = (X(:,i)-min(X(:,i)))/(max(X(:,i))-min(X(:,i)));
    end
end

%% Perform MeanCut algorithm
% Iris: knum = 21; percentile = 0.85;
% Wine: knum = 16; percentile = 0.94;
% Seeds: knum = 30; percentile = 0.77;
% Dermatology: knum = 12; percentile = 0.73;
% Control: knum = 33; percentile = 0.98;
% Breast-Cancer: knum = 36; percentile = 0.69;
% Mice: knum = 24; percentile = 0.98;
% COIL20: knum = 33; percentile = 0.60;
% Digits: knum = 34; percentile = 0.86;
% Segment: knum = 24; percentile = 0.97;
% Satimage: knum = 18; percentile = 0.99;
% MNIST10k: knum = 57; percentile = 0.95;
% PenDigits: knum = 52; percentile = 0.87;
% Shuttle: knum = 41; percentile = 0.97;

knum = 21;
percentile = 0.85;
[cluster] = ImprovedMeanCut(X, knum, percentile);

%% Visualize and evaluate the result
addpath ClusterEvaluation
[ Accuracy, NMI, ARI, Fscore, JI, RI] = ClustEval(ref, cluster);


