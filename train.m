numOfTweets = 10000;
numOfToken = 80000;
numOfClass = 8;

tokenlist = zeros(1, numOfToken);
trainMatrix = zeros(numOfClass, numOfToken);

% get P(spam)
p = 1 / numOfClass;

% get P(words|spam)
for i = 1:numOfClass
    totalFrequency = sum(trainMatrix(i, :));
    trainMatrix(i, :) = (trainMatrix(i, :) + 1) / (totalFrequency + numToken);
end


tweet = zeros(1, numOfToken);

p = zeros(1, numOfClass);
maxClass = 1;
ratio = 0;
for i = 1:numOfClass
   for tokenIndex = 1:numOfToken
       ratio = ratio + tweet(tokenIndex) * log(trainMatrix(maxClass, tokenIndex));
       ratio = ratio - tweet(tokenIndex) * log(trainMatrix(i, tokenIndex));
   end
   if ratio < 0
       maxClass = i;
   end
end

maxClass

