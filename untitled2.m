imds = imageDatastore('C:\Users\aswin\OneDrive\Desktop\CASIA1\CASIA1', 'IncludeSubfolders', true, 'LabelSource','foldernames');
net = alexnet;
numClasses = numel(categories(imds.Labels));
newLayers = [
    fullyConnectedLayer(numClasses, 'Name', 'fc8')
    softmaxLayer('Name', 'softmax')
    classificationLayer('Name', 'classoutput')
];
net = replaceLayer(net, 'fc8',newLayers);
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 20, 'MiniBatchSize', 32);
trainedNet = trainNetwork(imds,net,opts);
testim = imread('path/to/testimage.jpg');
predictedLabel = classify(trainedNet,testim);