tic;

M = [0 1 0; -1 0 -1; 0 1 0];
y = deriveflavourvectorONEFS(M);
disp('Solution vector coefficients:');
disp(y);

toc;
