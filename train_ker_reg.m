%% Load and prep data
% loadData
numTrain = size(trainMatrix, 1);
numTest = size(testMatrix, 1);
results = ones(numTest, 1);

%% Kernel Regression

% taus = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
taus = [0.0001 0.001 0.01 0.1 1 10 100 1000];
taus = linspace(0.0001, 0.001, 10);
taus = [0.00001 0.0001];
% taus = [1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
% taus = [1000 10000 100000 1000000];
% taus = [5000 6000 7000 8000 9000 10000];
% taus = linspace(0, 1000000);
% taus = linspace(1000, 10000, 20);
% taus = .0001;
% taus = 1000000;

bestDev = 100000000;
bestTau = 0;
for tau = taus
    fprintf('Testing tau value %d...\n\n', tau);
    g = @(x1,x2)exp(-dot(x1-x2,x1-x2)/(2*tau^2));
    g = @(x1,x2)exp(-sqrt(dot(x1-x2,x1-x2))/(2*tau^2));
    
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
    end
    corr = corrcoef(testLabel, results);
    stdDev = std(testLabel, results);
    if(stdDev < bestDev)
        bestDev = stdDev;
        bestTau = tau;
    end
    fprintf('\nStandard Deviation %d\n\n', stdDev);
    fprintf('\nCorr %d\n\n', corr(2,1));
    
    [testLabel results]
    
    fprintf('-----------------------------------------------------\n\n');
    
end
fprintf('Best stdDev: %d\n', bestDev);
fprintf('Best tau: %d\n', bestTau);
