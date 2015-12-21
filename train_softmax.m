function y = train_softmax(error)
% error is the allowed error range.
loadData
results = ones(numTest, 1);
numFeatures = size(trainMatrix,2);

% Learning rate
C = 0.05;

w = zeros(numFeatures, numOfClass);
w(:, end) = zeros(numFeatures,1);
deltaw = gradient(w, trainMatrix, trainLabel);
while(norm(deltaw, 2) > 0.1)
  w = w + C * deltaw;
  deltaw = gradient(w, trainMatrix, trainLabel);
end
accuracy = 0;
for i = 1 : numTest
  predict = ones(numOfClass,1);
  for j = 1 : numOfClass-1
    predict(j) = exp(testMatrix(i,:) * w(:, j));
  end
  [~, I] = sort(predict, 'descend');
  results(i) = I(1) + 1; % index is 1-8, but label is 2-9, so +1 to get label from index
  error
  accuracy = accuracy + (abs(results(i)-testLabel(i))<=error);
end
accuracy = accuracy / numTest;
fprintf('test Label, predict Label\n')
disp([testLabel results])
fprintf('Allowing error within %d, accuracy is: %f\n', error, accuracy)
end

%% Calculate gredient
function deltaw = gradient(w, x, t)
x = x';
k = size(w, 2);
deltaw = zeros(size(w));
for m = 1 : k-1
  for i = 1 : size(x,2)
    sum_e = 0;
    for j = 1 : k-1
      sum_e = sum_e + exp(w(:, j)' * x(:, i));
    end
    deltaw(:, m) = deltaw(:, m) + x(:, i) * ((t(i)==m)...
      - exp(w(:,m)'*x(:,i))/(sum_e+1)) ;
  end
end
end