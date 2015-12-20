%% load data
clear

load('data/W2Vtrain2000-300.mat');
load('data/W2Vtest2000-300.mat');

% load('data/RawTrain2000-300.mat');
% load('data/RawTest2000-300.mat');
% trainMatrix = double(trainMatrix);
% testMatrix = double(testMatrix);
% numOfToken = 9230;
% for i = 1:size(trainMatrix, 1)
%     totalFrequency = sum(trainMatrix(i, :));
%     trainMatrix(i, :) = (trainMatrix(i, :) + 1) / (totalFrequency + numOfToken);
% end
% for i = 1:size(testMatrix, 1)
%     totalFrequency = sum(testMatrix(i, :));
%     testMatrix(i, :) = (testMatrix(i, :) + 1) / (totalFrequency + numOfToken);
% end


%% algorithm


for i=1:4
    fprintf('k=%d',i);
    mdl = fitcknn(trainMatrix, trainLabel, 'NumNeighbors', i);
    train_pred = predict(mdl, trainMatrix);
    fprintf('train accuracy: %f\n', sum(abs(int16(train_pred) - int16(trainLabel))<=1)/size(trainLabel,1));
    test_pred = predict(mdl, testMatrix);
    disp('result');
    disp([testLabel test_pred])
    fprintf('test accuracy:%f\n', sum(abs(int16(test_pred) - int16(testLabel))<=1)/size(testLabel, 1));  
    corr = corrcoef(double(testLabel), double(test_pred));
    fprintf('correlation: %f\n', corr(2,1));
end
