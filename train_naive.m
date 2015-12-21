%% Load and prep data
clear;
% loadData

addpath(genpath('raw_train'))
addpath(genpath('raw_test'))

numOfToken = length(load('raw_train/2.out'));
numOfClass = 8;

% Train
trainLabel = [2:9]';
trainMatrix = zeros(numOfClass, numOfToken);
for i = 2:9
    trainMatrix(i - 1, :) = load(sprintf('raw_train/%d.out', i));
end

% Test model
dir_name = 'raw_test/*.out';
files = dir(dir_name);
numFiles = size(files,1);

testLabel = [5 7 3 5 9 9 6 5 8 2 8 7 6 3 2 4 8 6 6 3 7 4 8 7 6]';
testMatrix = zeros(numFiles, numOfToken);
% Test matrix
for n = 1:size(files,1)
    fileName = files(n).name;
%     fprintf('Loading %s vector\n', fileName);
    testMatrix(n,:) = load(fileName);
end

results = ones(size(files,1), 1);

numOfClass = 8;
numTrain = size(trainMatrix, 1);
numTest = size(testMatrix, 1);
results = ones(numTest, 1);

%% Naive Bayes
% In theory, you should only run raw vectors with these

% get P(spam)
p = 1 / numOfClass;

% get P(words|spam)
for i = 1:numOfClass
    totalFrequency = sum(trainMatrix(i, :));
    trainMatrix(i, :) = (trainMatrix(i, :) + 1) / (totalFrequency + numOfToken);
end

for n = 1:size(files,1)
    fileName = files(n).name;
    fprintf('Twerating for %s: ', fileName);

    maxClass = 1;
    for i = 1:numOfClass
       ratio = 0;
       for tokenIndex = 1:numOfToken
           ratio = ratio + testMatrix(n,tokenIndex) * log(trainMatrix(maxClass, tokenIndex));
           ratio = ratio - testMatrix(n,tokenIndex) * log(trainMatrix(i, tokenIndex));
       end
       if ratio < 0
           maxClass = i;
       end
    end
    fprintf('%d\n', maxClass);
    results(n) = maxClass;
end

error = 1;
accuracy = 0;
for j = 1 : numTest
    accuracy = accuracy + (abs(results(j)-testLabel(j))<=error);
end
accuracy = accuracy / numTest;
corr = corrcoef(testLabel, results);
disp([testLabel results])
fprintf('Corr %d\n', corr(2,1));
fprintf('Accuracy %d\n\n', accuracy);