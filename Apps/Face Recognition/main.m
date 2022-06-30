%% Input face images and generate true labels
load Yale
n = 165;
s = 64;
t = 64;
Y = zeros(227,227,3,n);
oriY = zeros(s,t,n);
for i = 1:n
    oriY(:,:,i) = reshape(fea(i,:),s,t);
    Y(:,:,1,i) = imresize(reshape(fea(i,:),s,t),[227 227]); 
    Y(:,:,2,i) = imresize(reshape(fea(i,:),s,t),[227 227]); 
    Y(:,:,3,i) = imresize(reshape(fea(i,:),s,t),[227 227]); 
end

ref = zeros(n,1);
for i=1:n
    ref(i) = ceil(i/11);
end

%% Extract Gabor, Gist, LBP and ResNet18 features
gabor = [];
for i = 1:n
    addpath GaborFeatureExtract
    gaborArray = gaborFilterBank(5,8,39,39);
    gabor = [gabor; (gaborFeatures(oriY(:,:,i),gaborArray,15,15))'];
end
gist = [];
for i = 1:n
    addpath gist
    gist = [gist;extract_gist(oriY(:,:,i))];
end
gist = double(gist);

lbp = [];
for i = 1:n
    addpath lbp
    lbp = [lbp;extract_lbp(oriY(:,:,i))];
end
lbp = double(lbp);

net = resnet18;
augImds = augmentedImageDatastore(net.Layers(1, 1).InputSize(1:2),Y);
cnn = squeeze(activations(net,augImds,'fc1000'))';
cnn = double(cnn);


%% Concat the image features and reduce the dimensions using PCA
dim = 22;
X = [pca(gabor,dim),pca(gist,dim),pca(lbp,dim),pca(cnn,dim)];

%% Normalize data using max-min function
for i=1:length(X(1,:))
    if((max(X(:,i))-min(X(:,i)))>0)
        X(:,i) = (X(:,i)-min(X(:,i)))/(max(X(:,i))-min(X(:,i)));
    end
end

%% Perform MeanCut algorithm
knum = 8;
percentile = 0.71;
[cluster] = ImprovedMeanCut(X, knum, percentile);

%% Visualize and evaluate the result
addpath ClusterEvaluation
[ Accuracy, NMI, ARI, Fscore, JI, RI] = ClustEval(ref, cluster);


