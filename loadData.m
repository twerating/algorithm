% %% Load raw data
% 
% clear; clc; close all;
% addpath(genpath('raw_train'))
% addpath(genpath('raw_test'))
% 
% numOfTweets = 10000;
% numOfToken = length(load('raw_train/2.out'));
% numOfClass = 8;
% 
% % Train
% trainMatrix = zeros(numOfClass, numOfToken);
% for i = 2:9
%     trainMatrix(i - 1, :) = load(sprintf('raw_train/%d.out', i));
% end
% 
% % Test model
% dir_name = 'raw_test/*.out';
% files = dir(dir_name);
% 
% trainLabel = [2:9]';
% 
% testLabel = [5 7 3 5 9 9 6 5 8 2 8 7 6 3 2 4 8 6 6 3 7 4 8 7 6]';

%% Load w2v data

clear; clc; close all;
addpath(genpath('w2v_train'))
addpath(genpath('w2v_test'))

numOfTweets = 10000;
numOfToken = length(load('w2v_train/2.out'));
numOfClass = 8;

% Train
trainMatrix = zeros(numOfClass, numOfToken);
for i = 2:9
    trainMatrix(i - 1, :) = load(sprintf('w2v_train/%d.out', i));
end

% Test model
dir_name = 'w2v_test/*.out';
files = dir(dir_name);

trainLabel = [2:9]';

testLabel = [5 7 3 5 9 9 6 5 2 8 7 6 3 2 6 7 4 8 7 6]';