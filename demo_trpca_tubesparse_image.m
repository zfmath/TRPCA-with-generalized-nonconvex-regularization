addpath(genpath(cd))
clear;
clc;
close all;
rng('default');
%%
pic_name = './testimg.jpg';
X = double(imread(pic_name));
X = X/255;
maxP = max(abs(X(:)));
[n1,n2,n3] = size(X);
Xn = X;
%%
R = zeros(n1,n2,n3);  % for multi tube noise
rhos = 0.2;
temp = (rand(n1,n2)<rhos);
R(:,:,1:n3) = repmat(temp,[1 1 3]);
S = randn(size(X));
S = S.*R;
%%
Xn = Xn+S;
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
[Xhat,~,~,~] = trpca_gnr_tube(fun1,fun2,Xn,lambda,f1_gamma,f2_gamma,opts);
time=toc
%%
Xhat = max(Xhat,0);
Xhat = min(Xhat,maxP);
psnr = PSNR(X,Xhat,maxP)
ssim = ssim(X, Xhat)
pcode prox_wtl1
pcode prox_wtl21_tube
pcode prox_wtnn
pcode trpca_gnr
pcode trpca_gnr_tube