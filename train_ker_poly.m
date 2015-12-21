%% Load and prep data
clear; clc;
loadData

%% Kernel Regression

error = 1;

M = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
% M = [100 1000 10000 100000 1000000 10000000];
C = [0 0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
% taus = [0.0001 0.001 0.01 0.1 1 10 100 1000];
% taus = [0.05 0.1 1 10 100 1000];

bestCorr = -2;
bestAcc = 0;
bestM = 0;
bestC = 0;
for c = C
for m = M
    fprintf('Testing M value %d...\n', m);
    fprintf('Testing C value %d...\n\n', c);
%     g = @(x1,x2)exp(-dot(x1-x2,x1-x2)/(2*tau^2));
    g = @(x1,x2)(dot(x1,x2)+c)^m;
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
        bestM = m;
        bestC = c;
        bestAcc = accuracy;
        best = [testLabel results];
    end
    disp([testLabel results])
    fprintf('Accuracy %d\n\n', accuracy);
    fprintf('Corr %d\n', corr(2,1));
    fprintf('-----------------------------------------------------\n\n');
    
end
end
fprintf('Best accuracy %d\n', bestAcc);
fprintf('Best corr: %d\n', bestCorr);
fprintf('Best M: %d\n', bestM);
fprintf('Best C: %d\n', bestC);
best
plot(best(:,1),best(:,2), 'bo')

coeffs = polyfit(best(:,1), best(:,2), 1);
% Get fitted values
fittedX = linspace(min(best(:,1)), max(best(:,2)), 200);
fittedY = polyval(coeffs, fittedX);
% Plot the fitted line
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 3);