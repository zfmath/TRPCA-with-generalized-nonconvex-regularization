addpath(genpath(cd))
clear;
clc;
close all;
%%
pic_name = './testimg.jpg';
X = double(imread(pic_name));
X = X/255;
maxP = max(abs(X(:)));
[n1,n2,n3] = size(X);
Xn = X;
rhos = 0.1;
ind = find(rand(n1*n2*n3,1)<rhos);
Xn(ind) = rand(length(ind),1);
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
[Xhat,~,~,~] = trpca_gnr(fun1,fun2,Xn,lambda,f1_gamma,f2_gamma,opts);
time=toc
%%
Xhat = max(Xhat,0);
Xhat = min(Xhat,maxP);
psnr = PSNR(X,Xhat,maxP)
ssim = ssim(X, Xhat)






