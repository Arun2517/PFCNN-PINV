clc;
clear;
close all;
%%
digitDatasetPath = fullfile(matlabroot,...
    'toolbox','nnet','nndemos','nndatasets','DigitDataset');

imds = imageDatastore(digitDatasetPath,...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');

imds.ReadFcn = @(x) imresize(imread(x),[32 32]);

[trainDS,testDS] = splitEachLabel(imds,0.8,'randomized');
%%
F(:,:,1)=[-1 -1 -1;
    0  0  0;
    1  1  1];

F(:,:,2)=[-1 0 1;
    -1 0 1;
    -1 0 1];

F(:,:,3)=[-1 -1 0;
    -1 0 1;
    0 1 1];

F(:,:,4)=[0 1 1;
    -1 0 1;
    -1 -1 0];
%%
numTrain=numel(trainDS.Files);

HTrain=[];

for i=1:numTrain

    img=readimage(trainDS,i);

    img=double(img)/255;

    feature=[];

    for k=1:4

        convImg=imfilter(img,F(:,:,k),'replicate');

        convImg=max(convImg,0);      % ReLU

        feature(k)=mean(convImg(:)); % GAP

    end

    HTrain=[HTrain;feature];

end
%%
labels=grp2idx(trainDS.Labels);

numClasses=numel(unique(labels));

T=zeros(length(labels),numClasses);

for i=1:length(labels)

    T(i,labels(i))=1;

end
%%
W=pinv(HTrain)*T;
%%
numTest=numel(testDS.Files);

HTest=[];

for i=1:numTest

    img=readimage(testDS,i);

    img=double(img)/255;

    feature=[];

    for k=1:4

        convImg=imfilter(img,F(:,:,k),'replicate');

        convImg=max(convImg,0);

        feature(k)=mean(convImg(:));

    end

    HTest=[HTest;feature];

end
%%
Y=HTest*W;

[~,pred]=max(Y,[],2);
%%
testLabels=grp2idx(testDS.Labels);

accuracy=sum(pred==testLabels)/length(testLabels)*100;

fprintf('Accuracy = %.2f %%n',accuracy); %[output:7fa27dba]


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:7fa27dba]
%   data: {"dataType":"text","outputData":{"text":"Accuracy = 18.10 %n","truncated":false}}
%---
