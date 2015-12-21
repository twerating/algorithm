clc;

disp('---------------------------------------');
disp('Linear Regression using Newtons Method');
disp('---------------------------------------');
train_newton
disp('---------------------------------------');
disp('Naive Bayes');
disp('---------------------------------------');
train_naive
disp('---------------------------------------');
disp('Kernel Regression');
disp('---------------------------------------');
train_ker_reg
disp('---------------------------------------');
disp('KNN');
disp('---------------------------------------');
train_knn
disp('---------------------------------------');
disp('Linear kernel SVM');
disp('---------------------------------------');
train_svm_lin
disp('---------------------------------------');
disp('Polynomial kernel SVM');
disp('---------------------------------------');
train_svm_poly

%% Prepare SVM Rank data export
load('data/W2Vtrain2000-300.mat');
load('data/W2Vtest2000-300.mat');

trainLabel = double(trainLabel);
testLabel = double(testLabel);
trainMatrix = double(trainMatrix);
testMatrix = double(testMatrix);

numOfClass = 8;
numTrain = size(trainMatrix, 1);
numTest = size(testMatrix, 1);
results = ones(numTest, 1);

for i = 1:numTrain
    trainMatrix(i,:) = trainMatrix(i,:) / norm(trainMatrix(i,:));
end
for i = 1:numTest
    testMatrix(i,:) = testMatrix(i,:) / norm(testMatrix(i,:));
end

sendToText
disp('---------------------------------------');
disp('SVM rank ready to execute...');
disp('---------------------------------------');

% After data has been loaded, cd to top folder and
% run make svm. Find the resulting predictions in
% svm_rank_data/svm_rank_test_pred.txt.
% Run corrcoef between that vector and resulting
% true test labels by running:
% 
% testPred = [{COPY PREDICTIONS HERE}];
% corrcoef(testLabel, testPred)