loadData

initW = 1e-2;
initB = 1e-1;

initConvnetModel.layers = {};

cnn_layer

% Some training options that you can use without changes
opts.continue = true;
opts.gpus = [];
opts.expDir = fullfile('tmp', 'convnetSmall');
if exist(opts.expDir, 'dir') ~= 7, mkdir(opts.expDir); end

% In this mini project, we just specify the parameters for you
% You will need to find out the optimal parameters by yourself in
% real-world practice.
opts.learningRate = 1e-2;
opts.batchSize = 128;
opts.numEpochs = 30;

convnetModel = [];

convnetModel = cnnTrain(trainMatrix, trainLabel, testMatrix, testLabel, initConvnetModel, opts)

% Predict on the validation data
% A wrapper function cnnPredict has been provided ('toolbox0/cnn/cnnPredict.m')
convnetValPredictionSmall = cnnPredict(testMatrix, convnetModel, opts);
convnetValAccuracySmall = mean(testLabel == convnetValPredictionSmall)*100;
fprintf('Convolutional neural network (small) validation accuracy: %g%%\n', convnetValAccuracySmall);
% convnetTestPredictionSmall = cnnPredict(testData32x32NormalizedStandardized, convnetModel, opts);
