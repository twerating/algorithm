format_svm:
	# python svmRankFormat.py w2v_test/*.out w2v_test/labels.txt w2v_test_svmRank.txt
	# python svmRankFormat.py w2v_train/*.out w2v_train/labels.txt w2v_train_svmRank.txt
	python svmRankFormat2.py svm_rank_data/trainx.txt svm_rank_data/trainy.txt svm_rank_data/svm_rank_train.txt
	python svmRankFormat2.py svm_rank_data/testx.txt svm_rank_data/testy.txt svm_rank_data/svm_rank_test.txt

train_rank_svm:
	# svm_rank/svm_rank_learn -c 0.5 w2v_train_svmRank.txt model.dat
	svm_rank/svm_rank_learn -c 0.5 svm_rank_data/svm_rank_train.txt svm_rank_data/model.dat

test_rank_svm:
	svm_rank/svm_rank_classify svm_rank_data/svm_rank_test.txt svm_rank_data/model.dat svm_rank_data/svm_rank_test_pred.txt

svm:
	make format_svm
	make train_rank_svm
	make test_rank_svm

clean:
	rm -f *.o *~ socket_example $(EXEC_NAME)

# If the first argument is "run"...
ifeq (test,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: test
test :
	g++ $(RUN_ARGS).cpp libfs_client.a -std=c++11 -o $(RUN_ARGS).out
	./$(RUN_ARGS).out localhost 5000 > $(RUN_ARGS).txt

testall:
	sh runtests.sh

