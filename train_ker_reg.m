%% Load and prep data

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

trainLabel = [2:9]';

testLabel = [5 7 3 5 9 9 6 5 8 2 8 7 6 3 2 4 8 6 6 3 7 4 8 7 6]';

%% Kernel Regression

% taus = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
% taus = [0.0000001 0.000001 0.00001];
% taus = [1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
taus = [1000 10000 100000 1000000];
% taus = [5000 6000 7000 8000 9000 10000];
% taus = linspace(0, 1000000);
% taus = .0001;
% taus = 1000000;
ourLabel = ones(size(testLabel));

bestDev = 100000000;
bestTau = 0;
for tau = taus
    fprintf('Testing tau value %d...\n', tau);
    g = @(x1,x2)exp(-dot(x1-x2,x1-x2)/(2*tau^2));

    for n = 1:size(files,1)
        fileName = files(n).name;
        fprintf('Twerating for %s: ', fileName);
        tweet = load(fileName);

        numerator = 0;
        denominator = 0;
        for i = [1:numOfClass]
            kernel = g(tweet,trainMatrix(i,:));
            numerator = numerator + kernel*trainLabel(i);
            denominator = denominator + kernel;
        end
%         numerator
%         denominator 
        
        label = numerator/denominator;
        ourLabel(n) = label;
        fprintf('%d\n', label);
    end
    stdDev = std(testLabel, ourLabel);
    if(stdDev < bestDev)
        bestDev = stdDev;
        bestTau = tau;
    end
    fprintf('Standard Deviation %d\n\n', stdDev);

end
fprintf('Best stdDev: %d\n', bestDev);
fprintf('Best tau: %d\n', bestTau);
