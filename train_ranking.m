%% Load and prep data
loadData
results = ones(size(files,1), 1);

%% Ranking SVM

% tryC = [5];
% tryn0 = [.5];
% tryIter = [6000];
tryC = [0.01, 0.1, 1, 10, 100, 1000];
tryn0 = [0.01, 0.5, 1.0, 10, 100];
tryIter = [5,50,100,1000,5000,6000];
w = zeros(1,size(trainMatrix, 2));
numTrain = size(trainMatrix, 1);
divisor = numTrain*(numTrain-1)/2;

% Best result and hyper-parameters
bestCorr = -1;
bestC = 0;
bestn0 = 0;
bestIter = 5;

% IMPORTANT: Flip matrix upside down to get ranking order from greatest to
% least.
trainMatrix = flipud(trainMatrix);
trainLabel = flipud(trainLabel);
% testing the hyper-parameter
for C = tryC
for n0 = tryn0
g = @(n0,i)n0/(1+i*n0);
for iter = tryIter
w = zeros(1,size(trainMatrix, 2));
for n = 1:iter
for i = 1:numTrain-1
    for j = i+1:numTrain
        indicator = logical((trainMatrix(i,:) - trainMatrix(j,:))*w' < 1);
        wGrad = w/divisor - C*indicator*(trainMatrix(i,:) - trainMatrix(j,:));
        w = w - g(n0,n)*wGrad;
    end
end
end

% Run w on train results
trainLabel_pred = trainMatrix*w';
M = corrcoef(trainLabel, trainLabel_pred);
fprintf('Train correlation = %d\n\n', M(2,1));

% Run w on val results
testLabel_pred = testMatrix*w';
M = corrcoef(testLabel, testLabel_pred);
fprintf('Val correlation = %d\n\n', M(2,1));

fprintf('Hyper-parameters: corr = %d, C = %d, ', M(2,1), C);
fprintf('bestn0 = %d, bestIter = %d, -----------\n\n', n0, iter);

% Update best hyper-parameters
if(M(2,1) > bestCorr)
    bestCorr = M(2,1);
    bestIter = iter;
    bestC = C;
    bestn0 = n0;
end
end
end
end
fprintf('Best hyper-parameters: bestCorr = %d, bestC = %d, ', bestCorr, bestC);
fprintf('bestn0 = %d, bestIter = %d, -----------\n\n', bestn0, bestIter);