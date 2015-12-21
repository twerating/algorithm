if ~exist('svm_rank_data', 'dir'), mkdir('svm_rank_data'); end

dlmwrite('svm_rank_data/trainx.txt', trainMatrix);
dlmwrite('svm_rank_data/trainy.txt', trainLabel);
dlmwrite('svm_rank_data/testx.txt', testMatrix);
dlmwrite('svm_rank_data/testy.txt', testLabel);