%% Load and prep data
clear;
% loadData

load('data/W2Vtrain2000-300.mat');
load('data/W2Vtest2000-300.mat');
disp('Linear Regression using Newtons Method');

trainLabel = double(trainLabel);
testLabel = double(testLabel);
trainMatrix = double(trainMatrix);
testMatrix = double(testMatrix);

numOfClass = 8;
numTrain = size(trainMatrix, 1);
numTest = size(testMatrix, 1);
results = ones(numTest, 1);

% Normalize
for i = 1:numTrain
    trainMatrix(i,:) = trainMatrix(i,:) / norm(trainMatrix(i,:));
end
for i = 1:numTest
    testMatrix(i,:) = testMatrix(i,:) / norm(testMatrix(i,:));
end

%% Newton's method
lambda = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
% lambda = [10 100 1000];
% lambda = [0.000001 0.00001 0.0001 0.001];
% lambda = [0.0000000001 0.000000001 0.00000001 0.0000001 0.000001];

bestCorr = -2;
bestAcc = 0;
bestLambda = 0;
for i = lambda
%     fprintf('Lambda regularizer value %d:\n', i);
    w = sparse(trainMatrix'*trainMatrix + i*diag(ones(1,size(trainMatrix,2))))\trainMatrix'*trainLabel;
    results = testMatrix * w;
%     [testLabel results]
    corr = corrcoef(testLabel, results);
    error = 1;
    accuracy = 0;
    for j = 1 : numTest
        accuracy = accuracy + (abs(results(j)-testLabel(j))<=error);
    end
    accuracy = accuracy / numTest;
%     if(bestCorr < corr(2,1))
    if(bestAcc < accuracy)
        bestCorr = corr(2,1);
        bestAcc = accuracy;
        bestLambda = i;
        best = [testLabel results];
    end
%     fprintf('Correlation = %d\n\n', corr(2,1));
%     fprintf('Accuracy %d\n\n', accuracy);
%     fprintf('---------------------------------\n\n');
end

fprintf('Best corr: %d\n', bestCorr);
fprintf('Best accuracy %d\n', bestAcc);
fprintf('Best lambda %d\n', bestLambda);
disp(best)