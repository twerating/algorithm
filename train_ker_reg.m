%% Load and prep data
loadData

%% Kernel Regression

error = 1;

% taus = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
taus = [0.0001 0.001 0.01 0.1 1 10 100 1000];
taus = [0.0001 0.001 0.01 0.1 1 10 100 1000];
% taus = linspace(0.0001, 0.001, 10);
taus = [0.05 1 10 100 1000];

bestDev = 100000000;
bestTau = 0;
for tau = taus
    fprintf('Testing tau value %d...\n\n', tau);
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
    stdDev = std(testLabel, results);
    if(stdDev < bestDev)
        bestDev = stdDev;
        bestTau = tau;
        best = [testLabel results];
    end
    disp([testLabel results])
    fprintf('Standard Deviation %d\n', stdDev);
    fprintf('Corr %d\n\n', corr(2,1));
    fprintf('Accuracy %d\n\n', accuracy);
    fprintf('-----------------------------------------------------\n\n');
    
end
fprintf('Best stdDev: %d\n', bestDev);
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