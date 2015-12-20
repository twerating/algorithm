%% load data
% loadData
clear

load('data/W2Vtrain2000-300.mat');
load('data/W2Vtest2000-300.mat');

% Load Term frequency vectors
% load('data/RawTrain2000-300.mat');
% load('data/RawTest2000-300.mat');
% 
% numOfToken = 9230;
% 
% trainMatrix = double(trainMatrix);
% testMatrix = double(testMatrix);
% 
% for i = 1:size(trainMatrix, 1)
%     totalFrequency = sum(trainMatrix(i, :));
%     trainMatrix(i, :) = (trainMatrix(i, :) + 1) / (totalFrequency + numOfToken);
% end
% for i = 1:size(testMatrix, 1)
%     totalFrequency = sum(testMatrix(i, :));
%     testMatrix(i, :) = (testMatrix(i, :) + 1) / (totalFrequency + numOfToken);
% end


t = templateSVM('KernelFunction','polynomial','KernelScale','auto');
% t = templateSVM('KernelFunction','linear','KernelScale','auto');
model = fitcecoc(trainMatrix, trainLabel, 'Learners', t);

prediction = predict(model, trainMatrix);
fprintf('train accuracy: %f',sum(abs(prediction - trainLabel)==0)/size(trainLabel, 1));
test_prediction = predict(model, testMatrix);
disp('prediction result');
[testLabel test_prediction]
fprintf('test accuracy: %f\n', sum(abs(int16(test_prediction) - int16(testLabel))<=1)/size(testLabel,1));
corr = corrcoef(double(testLabel), double(test_prediction));
fprintf('correlation: %f\n', corr(2,1));

