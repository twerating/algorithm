%% load data
% loadData
clear;

load('data/W2Vtrain2000-300.mat');
load('data/W2Vtest2000-300.mat');
disp('SVM Linear Kernel');

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

%% Algorithm

% t = templateSVM('KernelFunction','polynomial','KernelScale','auto');
t = templateSVM('KernelFunction','linear','KernelScale','auto');
model = fitcecoc(trainMatrix, trainLabel, 'Learners', t);

prediction = predict(model, trainMatrix);
fprintf('train accuracy: %f\n',sum(abs(prediction - trainLabel)==0)/size(trainLabel, 1));
test_prediction = predict(model, testMatrix);
disp('prediction result');
disp([testLabel test_prediction])
fprintf('test accuracy: %f\n', sum(abs(int16(test_prediction) - int16(testLabel))<=1)/size(testLabel,1));
corr = corrcoef(double(testLabel), double(test_prediction));
fprintf('correlation: %f\n', corr(2,1));

