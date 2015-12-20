dlmwrite('svm_rank_data/trainx.txt', trainMatrix);
dlmwrite('svm_rank_data/trainy.txt', trainLabel);
dlmwrite('svm_rank_data/testx.txt', testMatrix);
dlmwrite('svmc_rank_data/testy.txt', testLabel);