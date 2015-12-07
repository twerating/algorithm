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

% get P(spam)
p = 1 / numOfClass;

% get P(words|spam)
for i = 1:numOfClass
    totalFrequency = sum(trainMatrix(i, :));
    trainMatrix(i, :) = (trainMatrix(i, :) + 1) / (totalFrequency + numOfToken);
end

% Test model
dir_name = 'testVectors/*.out';
files = dir(dir_name);

for n = 1:size(files,1)
    fileName = files(n).name;
    fprintf('Twerating for %s: ', fileName);
    
    tweet = load(fileName);

    maxClass = 1;
    for i = 1:numOfClass
       ratio = 0;
       for tokenIndex = 1:numOfToken
           ratio = ratio + tweet(tokenIndex) * log(trainMatrix(maxClass, tokenIndex));
           ratio = ratio - tweet(tokenIndex) * log(trainMatrix(i, tokenIndex));
       end
       if ratio < 0
           maxClass = i;
       end
    end
    fprintf('%d\n', maxClass);
end