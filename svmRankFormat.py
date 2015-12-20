import sys

# To run:
# python svmRankFormat.py w2v_test/*.out w2v_test/labels.txt w2v_test_svmRank.txt

# Which file we're on
counter = 0

# Label vector
# label = [5, 7, 3, 5, 9, 9, 6, 5, 2, 8, 7, 6, 3, 2, 6, 7, 4, 8, 7, 6]

# Outfile to write to
print "\nOutput file: " + sys.argv[-1]
outFile = open(sys.argv[-1], 'w')
# Read in labels
with open (sys.argv[-2], "r") as myfile:
    label=myfile.read().split('\n')
print ""

# Read in vector features and format
for arg in sys.argv[1:-2]:
	print arg + " " + str(label[counter])
	with open (arg, "r") as myfile:
	    data=myfile.read()
	trainVec = str(label[counter]) + " qid:1 "
	featureCounter = 1
	for feature in data.split(' '):
		if(feature == ""):
			continue
		trainVec += str(featureCounter) + ":" + feature + " "
		featureCounter += 1
	trainVec += '\n'
	counter += 1
	outFile.write(trainVec)
outFile.close
print ""
