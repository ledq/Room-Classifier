clc;
clear;

%Define the image datastores
rootdir = '/MATLAB Drive/image/';
roomsDir = [rootdir 'Rooms'];
roomsImages = imageDatastore(roomsDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Split the data into training, validation, and test sets
[imdsTrain, imdsTest] = splitEachLabel(roomsImages, 0.7, 'randomized');
[imdsTrain, imdsValidate] = splitEachLabel(imdsTrain, 0.7, 'randomized');

% Get class names and number of classes from the training datastore
classNames = categories(imdsTrain.Labels);
numClasses = numel(classNames);

% Load a pretrained SqueezeNet and modify it for the number of classes in the dataset
net = imagePretrainedNetwork("squeezenet", NumClasses=numClasses);

% Analyze the network architecture (optional step)
analyzeNetwork(net)

% Get the input size of the network
inputSize = net.Layers(1).InputSize;

% Set up data augmentation parameters
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    RandXReflection=true, ...
    RandXTranslation=pixelRange, ...
    RandYTranslation=pixelRange);

% Create augmented image datastores for training, validation, and testing data
augimdsTrain = augmentedImageDatastore(inputSize(1:2), imdsTrain, ...
    DataAugmentation=imageAugmenter);
augimdsValidation = augmentedImageDatastore(inputSize(1:2), imdsValidate);
augimdsTest = augmentedImageDatastore(inputSize(1:2), imdsTest);

% Set training options for the network
options = trainingOptions("adam", ...
    ValidationData=augimdsValidation, ...
    ValidationFrequency=5, ...
    Plots="training-progress", ...
    Metrics="accuracy", ...
    Verbose=false);

% Train the network using the training data and the specified options
net = trainnet(augimdsTrain, net, "crossentropy", options);

% Predict the labels for the test data using the trained network
YTest = minibatchpredict(net, augimdsTest);
YTest = scores2label(YTest, classNames);

% Get the true labels of the test data
TTest = imdsTest.Labels;

% Plot the confusion matrix to visualize the performance of the classifier
figure
confusionchart(TTest, YTest);

% Calculate and display the accuracy of the predictions
acc = mean(TTest == YTest);
disp(['Test Accuracy: ', num2str(acc * 100), '%']);