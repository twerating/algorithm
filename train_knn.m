%% load data
clear

load('data/W2Vtrain2000-300.mat');
load('data/W2Vtest2000-300.mat');
disp('KNN');

trainLabel = double(trainLabel);
testLabel = double(testLabel);
trainMatrix = double(trainMatrix);
testMatrix = double(testMatrix);

%% algorithm

bestCorr = -2;
bestK = 0;
bestAcc = 0;
for i=1:4
%     fprintf('k=%d',i);
    mdl = fitcknn(trainMatrix, trainLabel, 'NumNeighbors', i);
    train_pred = predict(mdl, trainMatrix);
%     fprintf('train accuracy: %f\n', sum(abs(int16(train_pred) - int16(trainLabel))<=1)/size(trainLabel,1));
    test_pred = predict(mdl, testMatrix);
%     disp('result');
%     disp([testLabel test_pred])
    accuracy = sum(abs(int16(test_pred) - int16(testLabel))<=1)/size(testLabel, 1);
%     fprintf('test accuracy:%f\n', accuracy);  
    corr = corrcoef(double(testLabel), double(test_pred));
%     fprintf('correlation: %f\n', corr(2,1));
    if(bestAcc < accuracy)
        bestCorr = corr(2,1);
%         bestDev = stdDev;
        bestK = i;
        bestAcc = accuracy;
        best = [testLabel test_pred];
    end
%     fprintf('-----------------------------------------------------\n\n');
end
fprintf('Best corr: %d\n', bestCorr);
fprintf('Best accuracy %d\n', bestAcc);
fprintf('Best K: %d\n', bestK);
disp(best)