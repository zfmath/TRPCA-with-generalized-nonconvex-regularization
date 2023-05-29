addpath(genpath(cd))
clear
close all
rng('default');

%%
n1 = 80;
n2 = n1;
n3 = 80;
r = 0.05*n1; % tubal rank
L1 = randn(n1,r,n3)/n1;
L2 = randn(r,n2,n3)/n2;
L = tprod(L1,L2); % low rank part
%%
R = zeros(size(L));  % for multi tube noise
rhos = 0.05;
for i = 1:(size(L,3)/10)
    temp = (rand(size(L,1),size(L,2))<rhos);
    R(:,:,i*10-9:i*10) = repmat(temp,[1 1 10]);
end
S = randn(size(L));
S = S.*R;
%%
Xn = L+S;
%% 
opts.mu = 1e-4;
opts.max_mu = 1e10;
opts.tol = 1e-8;
opts.rho = 1.1;
opts.max_iter = 500;
opts.DEBUG = 1;
[n1,n2,n3] = size(Xn);
lambda = 1/sqrt(max(n1,n2)*n3);
fun1 = 'scad' ;      f1_gamma = 100 ;
fun2 = 'lp' ;        f2_gamma = 0.5 ;
%%
tic
[Lhat,Shat] = trpca_gnr_tube(fun1,fun2,Xn,lambda,f1_gamma,f2_gamma,opts);
time=toc
%%
Lr = norm(L(:)-Lhat(:))/norm(L(:))
Sr = norm(S(:)-Shat(:))/norm(S(:))
trank = r
trankhat = tubalrank(Lhat)