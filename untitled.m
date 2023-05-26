clc
clear all
close all
matlabpath='D:\Aaa Class\Sem 4\mutimedia processing\project';
datapath=fullfile(matlabpath,'eye');
train=imageDatastore(datapath,"IncludeSubfolders",true,LabelSource="foldernames");
count=train.countEachLabel;
%%%%%%% LOAD THE PRETRAINED ALEX NET %%%%%%%%%%%
net=alexnet;
layers=[imageInputLayer([280 320])
    net(2:end-3)
    fullyConnectedLayer(9)
    softmaxLayer
    classificationLayer
];

%%%%%%% TRAINING THE NETWORK %%%%%%%%%%%%%%%%%%
opt=trainingOptions("adam",'MaxEpochs',100,'InitialLearnRate',0.0001);
training=trainNetwork(train,layers,opt);

%%%%%%% TESTING THE NETWORK %%%%%%%%%%%%%%%%%%
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp;*.jfif','Select an image');
test_img=imread(strcat(PathName,FileName));
[class_out,score]=classify(training,test_img);
figure
imshow(test_img);
title(string(class_out));
% title(string(score));

msgbox(string(class_out));

%%%%%%%%%%%% PERFORMANCE EVALUATION %%%%%%%%%%%%%%
validationPath = fullfile(matlabpath,'eye');
imdsValidation = imageDatastore(validationPath, ...
'IncludeSubfolders',true,'LabelSource','foldernames');

class_out_validation = classify(training,imdsValidation);
validationError = mean(class_out_validation ~= imdsValidation.Labels);
disp("Validation error: " + validationError*100 + "%")

if (validationError*100>30)
    disp('The image is not found')
else (validationError*100<30)

    disp('The image is found')
end


%Plot the confusion matrix
cm = confusionchart(imdsValidation.Labels,class_out_validation);
cm.Title = "Confusion Matrix for Validation Data";
cm.ColumnSummary = "column-normalized";
cm.RowSummary = "row-normalized";
