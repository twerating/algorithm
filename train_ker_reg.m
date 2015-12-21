%% Load and prep data
clear;
% loadData
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

%% Kernel Regression

error = 1;

% taus = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
taus = [0.0001 0.001 0.01 0.1 1 10 100 1000];
taus = [0.05 0.1 1 10 100 1000];
% taus = linspace(0.0001, 0.001, 10);
% taus = [0.05 1 10 100 1000];
% taus = [0.05 1 10 100 1000];

bestCorr = -2;
bestTau = 0;
bestAcc = 0;
for tau = taus
%     fprintf('Testing tau value %d...\n\n', tau);
    g = @(x1,x2)exp(-dot(x1-x2,x1-x2)/(2*tau^2));
%     g = @(x1,x2)exp(-sqrt(dot(x1-x2,x1-x2))/(2*tau^2));
    accuracy = 0;
    for n = 1:numTest
        numerator = 0;
        denominator = 0;
        for i = 1:numTrain
            kernel = g(testMatrix(n,:),trainMatrix(i,:));
            numerator = numerator + kernel*trainLabel(i);
            denominator = denominator + kernel;
        end
        
        label = numerator/denominator;
%         fprintf('%d\n', label);
        results(n) = label;
        accuracy = accuracy + (abs(results(n)-testLabel(n))<=error);
    end
    accuracy = accuracy / numTest;
    corr = corrcoef(testLabel, results);
%     if(bestCorr < corr(2,1))
    if(bestAcc < accuracy)
        bestCorr = corr(2,1);
%         bestDev = stdDev;
        bestTau = tau;
        bestAcc = accuracy;
        best = [testLabel results];
    end
%     disp([testLabel results])
%     fprintf('Corr %d\n', corr(2,1));
%     fprintf('Accuracy %d\n\n', accuracy);
%     fprintf('-----------------------------------------------------\n\n');
    
end
fprintf('Best corr: %d\n', bestCorr);
fprintf('Best accuracy %d\n', bestAcc);
fprintf('Best tau: %d\n', bestTau);
best
plot(best(:,1),best(:,2), 'bo')

coeffs = polyfit(best(:,1), best(:,2), 1);
% Get fitted values
fittedX = linspace(min(best(:,1)), max(best(:,2)), 200);
fittedY = polyval(coeffs, fittedX);
% Plot the fitted line
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 3);