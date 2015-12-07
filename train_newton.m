clear; clc; close all;
addpath(genpath('train'))

numOfTweets = 10000;
numOfToken = length(load('2.out'));
numOfClass = 8;

% Train
trainMatrix = zeros(numOfClass, numOfToken);
for i = 2:9
    trainMatrix(i - 1, :) = load(sprintf('%d.out', i));
end

% Test model
dir_name = 'testVectors/*.out';
files = dir(dir_name);

trainMatrix = [ones(8,1),trainMatrix];
trainLabel = [2:9]';
lambda = [0.001 0.01 0.1 1 10 100];

%% Stochastic

rate = .000000026;

w = zeros(size(trainMatrix,2),1);
oldW = ones(size(trainMatrix,2),1);
counter = 0;

while counter < 20 %sum((w-oldW).^2) > 0.00001
    tweet = trainMatrix(mod(counter,numOfClass)+1,:);
    oldW = w;
    grad = (w'*tweet' - trainLabel(mod(counter,numOfClass)+1)) * tweet';
    w = w - rate*grad;
    counter = counter + 1;
end
counter


for n = 1:size(files,1)
    fileName = files(n).name;
    fprintf('Twerating for %s: ', fileName);

    tweet = load(fileName);
    tweet = [1 tweet];

    label = w'*tweet';

    fprintf('%d\n', label);
end

% for n = 1:size(files,1)
%     fileName = files(n).name;
%     fprintf('Twerating for %s: ', fileName);
% 
%     tweet = load(fileName);
%     tweet
% end

counter;

%% Newton's method
for i = lambda
    fprintf('\nLambda regularizer value %d:\n\n', i);
    w = sparse(trainMatrix'*trainMatrix + i*diag(ones(1,size(trainMatrix,2))))\trainMatrix'*trainLabel;
%     w = sparse(trainMatrix'*trainMatrix + i*ones(numOfToken))\trainMatrix'*trainLabel;

    % Test model
    dir_name = 'testVectors/*.out';
    files = dir(dir_name);

    for n = 1:size(files,1)
        fileName = files(n).name;
        fprintf('Twerating for %s: ', fileName);

        tweet = load(fileName);
        tweet = [1 tweet];

        label = w'*tweet';

        fprintf('%d\n', label);
    end
end