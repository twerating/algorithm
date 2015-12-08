%% Load and prep data
loadData
results = ones(size(files,1), 1);

%% Kernel Regression

% taus = [0.000001 0.00001 0.0001 0.001 0.01 0.1 1 10 100 1000];
% taus = [0.0000001 0.000001 0.00001];
% taus = [1000 2000 3000 4000 5000 6000 7000 8000 9000 10000];
taus = [1000 10000 100000 1000000];
% taus = [5000 6000 7000 8000 9000 10000];
% taus = linspace(0, 1000000);
% taus = linspace(1000, 10000, 20);
% taus = .0001;
% taus = 1000000;
ourLabel = ones(size(testLabel));

bestDev = 100000000;
bestTau = 0;
for tau = taus
    fprintf('Testing tau value %d...\n\n', tau);
    g = @(x1,x2)exp(-dot(x1-x2,x1-x2)/(2*tau^2));

    for n = 1:size(files,1)
        fileName = files(n).name;
        fprintf('Twerating for %s: ', fileName);
        tweet = load(fileName);

        numerator = 0;
        denominator = 0;
        for i = [1:numOfClass]
            kernel = g(tweet,trainMatrix(i,:));
            numerator = numerator + kernel*trainLabel(i);
            denominator = denominator + kernel;
        end
%         numerator
%         denominator 
        
        label = numerator/denominator;
        ourLabel(n) = label;
        fprintf('%d\n', label);
        results(n) = label;
    end
    stdDev = std(testLabel, ourLabel);
    if(stdDev < bestDev)
        bestDev = stdDev;
        bestTau = tau;
    end
    fprintf('\nStandard Deviation %d\n\n', stdDev);
    
    [testLabel results]
    
    fprintf('-----------------------------------------------------\n\n');
    
end
fprintf('Best stdDev: %d\n', bestDev);
fprintf('Best tau: %d\n', bestTau);
