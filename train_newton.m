%% Load and prep data
% loadData
numTrain = size(trainMatrix, 1);
numTest = size(testMatrix, 1);
results = ones(numTest, 1);

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

fprintf('Stochatic Gradient Descent:\n\n', i);

% for n = 1:numTest
%     fileName = files(n).name;
%     fprintf('Twerating for %s: ', fileName);
% 
%     label = w'*testMatrix(n,:)';
%     
%     results(n) = label;
%     fprintf('%d\n', label);
% end

results = testMatrix * w;

[testLabel results]
corr = corrcoef(testLabel, results);
corr(2,1)

fprintf('\n-----------------------------------------------------\n\n');

%% Newton's method
lambda = [0.001 0.01 0.1 1 10 100 1000];
% lambda = [10 100 1000];
lambda = [0.000001 0.00001 0.0001 0.001];
lambda = [0.0000000001 0.000000001 0.00000001 0.0000001 0.000001];

for i = lambda
    fprintf('Lambda regularizer value %d:\n\n', i);
    w = sparse(trainMatrix'*trainMatrix + i*diag(ones(1,size(trainMatrix,2))))\trainMatrix'*trainLabel;
%     w = sparse(trainMatrix'*trainMatrix + i*ones(numOfToken))\trainMatrix'*trainLabel;

%     for n = 1:size(files,1)
%         fileName = files(n).name;
%         fprintf('Twerating for %s: ', fileName);
% 
%         tweet = load(fileName);
%         label = w'*testMatrix(n,:)';
%         
%         results(n) = label;
%         fprintf('%d\n', label);
%     end
    fprintf('\n');
    
    results = testMatrix * w;
    
    [testLabel results]
    corr = corrcoef(testLabel, results);
    corr(2,1)
end