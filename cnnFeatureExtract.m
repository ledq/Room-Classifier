function [net, featuresTrain,featuresValid,featuresTest] = cnnFeatureExtract(trainImages,validateImages,testImages)
%% Feature Extraction

%load the network
net = alexnet;
net.Layers;
inputSize = net.Layers(1).InputSize;

%augment the images
augimdsTrain = augmentedImageDatastore(inputSize(1:2),trainImages);
augimdsValidation = augmentedImageDatastore(inputSize(1:2),validateImages);
augimdsTest = augmentedImageDatastore(inputSize(1:2),testImages);

%extract features
layer = 'fc6';
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');
featuresValid = activations(net,augimdsValidation,layer,'OutputAs','rows');
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows');

%normalize features
featuresTrain=normalizeFeatures01(featuresTrain);
featuresValid=normalizeFeatures01(featuresValid);
featuresTest=normalizeFeatures01(featuresTest);


end