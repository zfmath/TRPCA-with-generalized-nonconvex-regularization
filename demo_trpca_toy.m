addpath(genpath(cd))
clear
close all
%%
n1 = 80;
n2 = n1;
n3 = 80;
r = 0.05*n1; % tubal rank
L1 = randn(n1,r,n3)/n1;
L2 = randn(r,n2,n3)/n2;
L = tprod(L1,L2); % low rank part
%%
p = 0.05;
m = p*n1*n2*n3;
temp = rand(n1*n2*n3,1);
[B,I] = sort(temp);
I = I(1:m);
Omega = zeros(n1,n2,n3);
Omega(I) = 1;
E = sign(rand(n1,n2,n3)-0.5);
S = Omega.*E; % sparse part, S = P_Omega(E)
%%
Xn = L+S;
%%
lambda = 1/sqrt(n3*max(n1,n2));
fun1 = 'scad' ;      f1_gamma = 100 ;
fun2 = 'lp' ;        f2_gamma = 0.5 ;
opts.tol = 1e-8;
opts.mu = 1e-4;
opts.rho = 1.1;
opts.DEBUG = 1;
%%
tic
[Lhat,Shat] = trpca_gnr(fun1,fun2,Xn,lambda,f1_gamma,f2_gamma,opts);
time=toc;
%%
Lr = norm(L(:)-Lhat(:))/norm(L(:))
Sr = norm(S(:)-Shat(:))/norm(S(:))
sparsity = m
sparsityhat = length(find(round(Shat2)~=0))
trank = r
trankhat = tubalrank(Lhat2)




