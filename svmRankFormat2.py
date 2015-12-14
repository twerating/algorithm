import sys

# To run:
# python svmRankFormat2.py trainx.txt trainy.txt svm_rank_train.txt
# python svmRankFormat2.py testx.txt testy.txt svm_rank_test.txt

# Outfile to write to
print "\nOutput file: " + sys.argv[3]
outFile = open(sys.argv[3], 'w')
# Read in labels
with open (sys.argv[2], "r") as myfile:
    label=myfile.read().split('\n')
# Read in vectors
with open (sys.argv[1], "r") as myfile:
    vectors=myfile.read().split('\n')
    vectors.pop()
# print vectors
# print label

# Which file we're on
counter = 0
# Read in vector features and format
for vector in vectors:
	# Prepare string to write in file
	trainVec = str(label[counter]) + " qid:1 "
	featureCounter = 1
	for feature in vector.split(','):
		if(feature == ""):
			continue
		trainVec += str(featureCounter) + ":" + feature + " "
		featureCounter += 1
	trainVec += '\n'
	counter += 1
	outFile.write(trainVec)
outFile.close
print ""
