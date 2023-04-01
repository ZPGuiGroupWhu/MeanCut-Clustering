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
[ ACC, NMI, ARI, Fscore, JI, RI] = ClustEval(ref, cluster);

figure(2);
bar([ACC, NMI, ARI, Fscore, JI, RI]);
set(gca,'xticklabel',{'ACC','NMI','ARI','Fscore','JI','RI'})
