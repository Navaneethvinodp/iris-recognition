clc
clear all
close all

matlabpath = "D:\Aaa Class\Sem 4\mutimedia processing\project";
datapath = fullfile(matlabpath, 'eye');
train = imageDatastore(datapath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
count = train.countEachLabel;

%%%%%%% LOAD THE PRETRAINED ALEX NET %%%%%%%%%%%
net = alexnet;
layers = [imageInputLayer([280 320])
          net(2:end-3)
          fullyConnectedLayer(9)
          softmaxLayer
          classificationLayer];

%%% TRAINING THE NETWORK %%%%%%%%%%%%%%%%%%
opt = trainingOptions('adam', 'MaxEpochs', 10, 'InitialLearnRate', 0.0001);
training = trainNetwork(train, layers, opt);

%%%%%%% TESTING THE NETWORK %%%%%%%%%%%%%%%%%%
[FileName, PathName] = uigetfile('*.jpg;*.png;*.bmp;*.jfif', 'Select an image');
test_img = imread(fullfile(PathName, FileName));
[class_out, score] = classify(training, test_img);
figure;
imshow(test_img);
title(string(class_out));
% title(string(score));

msgbox(string(class_out));

%%%%%%%% PERFORMANCE EVALUATION %%%%%%%%%%%%%%
validationPath = fullfile('D:\Aaa Class\Sem 4\mutimedia processing\project\archive\MMU-Iris-Database');
imdsValidation = imageDatastore(validationPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

validationError = mean(class_out ~= imdsValidation.Labels);
disp("Validation error: " + validationError * 100 + "%")
if (validationError <= 50)
    disp('The image is found')
else
    disp('The image is not found')
end

%Plot the confusion matrix
% figure('Units', 'normalized', 'Position', [0.2 0.2 0.4 0.4]);
