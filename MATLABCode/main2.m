load('matrices_progress.mat', 'matrices');
disp(matrices);

M = matrices(:,:,1);

DeriveSchurIndexWL(M, 6);