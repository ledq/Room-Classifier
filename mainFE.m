% Find main directory
clear;
clc;
%change this according to the file location
rootdir = 'C:\Users\localmgr\Downloads\room_archive\room_archive';

imds = imageDatastore(...
    rootdir, ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

[trainImages, validateImages,testImages] = splitEachLabel(imds,0.5,0.2,0.3);

classNames = categories(trainImages.Labels);
numClasses = numel(classNames);


% FEATURE EXTRACTION

[net, featuresTrain,featuresValid,featuresTest] = cnnFeatureExtract(trainImages,validateImages,testImages);
% load("featureExtract.mat","featuresTrain","featuresValid","featuresTest");

%load("transferLearn1.mat","net","augimdsTrain","augimdsValidation","augimdsTest");
YTrain = trainImages.Labels;

% kernelScale = 9;
% boxConstraint = 16;
net = fitcecoc(featuresTrain, YTrain);

% PREDICTION ON VALID SET
YPred = predict(net,featuresValid);
YValidation = validateImages.Labels;
accuracy = mean(YPred==YValidation);

% %gridSearch(10,50,1,9,featuresTrain,YTrain,featuresValid,YValidation);
% % Calculate confusion matrix 
% [vTrueClasses, vDetectedClasses] = convertClassOutput(YValidation,YPred);
% [confusion, accuracy, tpr, fpr]=calculateConfusionMatrix(vTrueClasses, vDetectedClasses); %call confusion matrix function
% 
% 
% % PREDICTION ON TEST SET
% [YPredTest,tdistances] = predict(net,featuresTest);
% YTest = testImages.Labels;
% [tLabel,tScore] = predict(net, featuresTest);
% accuracyTest = mean(YPredTest == YTest);
% [testTrueClasses, testDetectedClasses] = convertClassOutput(YTest,YPredTest);
% [confusionLabels] = determineConfusionLabel(testTrueClasses, testDetectedClasses);
% ptScore = abs(tScore);
% 
% % Find images based on confusion labels (TP, FN, FP, TN) and their socores
% [imgIdx,imgcLabels,imgScores,cLabelNums] = findPics(confusionLabels,ptScore,testImages);
% 
% % GENERATE ROC
% thresholdSet = [-5 -4 -3 -2 -1 0 1 2 3 4 5];
% [nConfusion, nAccuracy, nTpr, nFpr] = generateROC(thresholdSet,testTrueClasses,testDetectedClasses,tdistances);
% 
