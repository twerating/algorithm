function train_softmax(error)
% error is the allowed error range.
loadData
results = ones(size(files,1), 1);

w = zeros(numOfToken, numOfClass);
w(:, end) = zeros(numOfToken,1);
deltaw = gradient(w, trainMatrix, trainLabel);
while(norm(deltaw, 2) > 8)
  w = w + 0.0005 * deltaw;
  deltaw = gradient(w, trainMatrix, trainLabel);
end
accuracy = 0;
for i = 1 : numFiles
  predict = ones(numOfClass,1);
  for j = 1 : numOfClass-1
    predict(j) = exp(testMatrix(i,:) * w(:, j));
  end
  [~, I] = sort(predict, 'descend');
  results(i) = I(1) + 1; % index is 1-8, but label is 2-9, so +1 to get label from index
  accuracy = accuracy + (abs(results(i)-testLabel(i))<=error);
end
accuracy = accuracy / numFiles;
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