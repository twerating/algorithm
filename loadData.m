% %% Load raw data
% 
% %clear; clc; close all;
% addpath(genpath('raw_train'))
% addpath(genpath('raw_test'))
% 
% numOfToken = length(load('raw_train/2.out'));
% numOfClass = 8;
% 
% % Train
% trainLabel = [2:9]';
% trainMatrix = zeros(numOfClass, numOfToken);
% for i = 2:9
%     trainMatrix(i - 1, :) = load(sprintf('raw_train/%d.out', i));
% end
% 
% % Test model
% dir_name = 'raw_test/*.out';
% files = dir(dir_name);
% numFiles = size(files,1);
% 
% testLabel = [5 7 3 5 9 9 6 5 8 2 8 7 6 3 2 4 8 6 6 3 7 4 8 7 6]';
% testMatrix = zeros(numFiles, numOfToken);
% % Test matrix
% for n = 1:size(files,1)
%     fileName = files(n).name;
% %     fprintf('Loading %s vector\n', fileName);
%     testMatrix(n,:) = load(fileName);
% end

% %% Load w2v data
% 
% % clear; clc; close all;
% addpath(genpath('w2v_train'))
% addpath(genpath('w2v_test'))
% 
% numOfTweets = 10000;
% numOfToken = length(load('w2v_train/2.out'));
% numOfClass = 8;
% 
% % Train model
% trainLabel = [2:9]';
% trainMatrix = zeros(numOfClass, numOfToken);
% for i = 2:9
%     trainMatrix(i - 1, :) = load(sprintf('w2v_train/%d.out', i));
% end
% 
% % Test model
% dir_name = 'w2v_test/*.out';
% files = dir(dir_name);
% numFiles = size(files,1);
% 
% testLabel = [5 7 3 5 9 9 6 5 2 8 7 6 3 2 6 7 4 8 7 6]';
% testMatrix = zeros(numFiles, numOfToken);
% % Test matrix
% for n = 1:size(files,1)
%     fileName = files(n).name;
% %     fprintf('Loading %s vector\n', fileName);
%     testMatrix(n,:) = load(fileName);
% end

% %% Load trainData300 testData300
% 
% % clear; clc; close all;
% addpath(genpath('data300'))
% 
% load('trainData300.mat')
% load('testData300.mat')
% trainLabel = double(trainLabel);
% testLabel = [2 8 7 6 3 2 5 7 3 6 5 9 7 9 4 6 8 4 7 6]';

% %% Load trainData500 testData500
% 
% % clear; clc; close all;
% addpath(genpath('data500'))
% 
% load('trainData500.mat')
% load('testData500.mat')
% trainLabel = double(trainLabel);
% testLabel = double(testLabel);

% %% Load rawTrain2 rawTest2
% 
% % clear; clc; close all;
% addpath(genpath('rawData2'))
% 
% load('RawTest.mat')
% load('RawTrain.mat')
% trainLabel = double(trainLabel);
% testLabel = double(testLabel);
% trainMatrix = double(trainMatrix);
% testMatrix = double(testMatrix);

% %% Load rawTrain3 rawTest3
% 
% % clear; clc; close all;
% addpath(genpath('rawData3'))
% 
% load('trainData500tweets.mat')
% load('testData500tweets.mat')
% trainLabel = double(trainLabel);
% testLabel = double(testLabel);
% trainMatrix = double(trainMatrix);
% testMatrix = double(testMatrix);

%% Load W2Vtest1000.mat W2Vtrain1000.mat

% clear; clc; close all;
addpath(genpath('data1000'))

load('W2Vtrain1000.mat')
load('W2Vtest1000.mat')
trainLabel = double(trainLabel);
testLabel = double(testLabel);
trainMatrix = double(trainMatrix);
testMatrix = double(testMatrix);

%% ALWAYS load these global variables

numOfClass = 8;
numTrain = size(trainMatrix, 1);
numTest = size(testMatrix, 1);
results = ones(numTest, 1);

% %% Normalize raw vector
% for i = 1:numTrain
%     trainMatrix(i,:) = trainMatrix(i,:) / norm(trainMatrix(i,:));
% end
% for i = 1:numTest
%     testMatrix(i,:) = testMatrix(i,:) / norm(testMatrix(i,:));
% end