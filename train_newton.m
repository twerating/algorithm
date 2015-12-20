%% Load and prep data
loadData

%% Stochastic

rate = .000000026;
rate = .5;

w = zeros(size(trainMatrix,2),1);
oldW = ones(size(trainMatrix,2),1);
counter = 0;

% while counter < 20 
while sum((w-oldW).^2) > 0.00001
    tweet = trainMatrix(mod(counter,numTrain)+1,:);
    oldW = w;
    grad = (w'*tweet' - trainLabel(mod(counter,numTrain)+1)) * tweet';
    w = w - rate*grad;
    counter = counter + 1;
end
counter

fprintf('Stochatic Gradient Descent:\n', i);

results = testMatrix * w;

disp([testLabel results])
corr = corrcoef(testLabel, results);
fprintf('Correlation = %d\n\n', corr(2,1));

%% Newton's method
lambda = [0.001 0.01 0.1 1 10 100 1000];
% lambda = [10 100 1000];
lambda = [0.000001 0.00001 0.0001 0.001];
% lambda = [0.0000000001 0.000000001 0.00000001 0.0000001 0.000001];

for i = lambda
    fprintf('---------------------------------\n\n');
    fprintf('Lambda regularizer value %d:\n', i);
    w = sparse(trainMatrix'*trainMatrix + i*diag(ones(1,size(trainMatrix,2))))\trainMatrix'*trainLabel;
    results = testMatrix * w;
    [testLabel results]
    corr = corrcoef(testLabel, results);
    fprintf('Correlation = %d\n\n', corr(2,1));
end