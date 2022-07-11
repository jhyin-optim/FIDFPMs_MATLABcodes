% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.      

% consider the regularized decentralized logistic regression
%
% $$ \displaystyle\min_x \frac{1}{m}\sum_{i=1}^m \log(1+ \exp(-b_ia_i^Tx)) 
% + \lambda \|x\|^2/2,$$
% 
% where $(a_i,b_i)_{i=1}^m$

% This MATLAB script follows the paper:
% Jian, J.B., Yin, J.H., Tang, C.M., Han, D.L.: A family of inertial derivative-free projection 
% methods for constrained nonlinear pseudo-monotone equations with
% applications. Submitted in Computational and Applied Mathematics.
%
% If you use/modify this code, please cite the just-mentioned paper appropriately.
%
% -----------------------------------------------------------------------
% Copyright (2022): Jianghua Yin
% ----------------------------------------------------------------------
%
% The first version of this code by Jianghua Yin, Dec., 16, 2019

% model=1 means -F(zk)'*dk ¡Ý sigma*tk*norm(dk)^2
% model=2 means -F(zk)'*dk ¡Ý sigma*tk*norm(F(zk))*norm(dk)^2
% model=3 means -F(zk)'*dk ¡Ý sigma*tk*norm(F(zk))/(1+norm(F(zk)))*norm(dk)^2
% model=4 means -F(zk)'*dk ¡Ý sigma*tk*max(lambda,min(nu,norm(Fz_new,2)))*norm(dk)^2

% All the test instances used are from the LIBSVM datasets and see the related paper£º
% Chang, C.C., Lin, C.J.: LIBSVM: a library for support vector machines. ACM Trans.
% Intell. Syst. Technol. 2(3), 1-27 (2011)
% Download link for these datasets: https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/.
% The downloaded datasets should be unzipped and put in the main directory.
% If you use the LIBSVM datasets, please cite the above mentioned paper appropriately.

clc;
clear all
close all

%%
% set random seed 
clear;
seed = 97006855;
ss = RandStream('mt19937ar','Seed',seed);
RandStream.setGlobalStream(ss);

ITR_max = 2000;
% set parameters for inertial derivative-free projection methods (IDFPMs)
para1.Itr_max = ITR_max;
para1.gamma = 1;         % the initial guess
para1.sigma = 1;         % the coefficient of line search 
para1.tau = 0.5;         % the compression ratio
% para1.alpha = 0.3;       % the coefficient of inertial step
para1.rho = 1.5;         % the relaxation factor 

% set parameters for HCGPM
para2.Itr_max = ITR_max;
para2.gamma = 1;         % the initial guess
para2.sigma = 0.0001;      % the coefficient of line search 
para2.tau = 0.5;         % the compression ratio
para2.rho = 1.5;         % the relaxation factor 

% set parameters for EPM
para3.Itr_max = ITR_max;
para3.gamma = 1;         % the initial guess
para3.sigma = 0.0001;      % the coefficient of line search 
para3.tau = 0.55;         % the compression ratio
para3.rho = 1.55;         % the relaxation factor

% the regularization parameter
lambda = 1e-1;
% setup TXT document
fid_tex=fopen('mytext.txt','w'); 

for i=1:10
    dataset = {'a1a.t','a2a.t','a3a.t','a4a.t','a5a.t','a6a.t','a7a.t',...
    'a8a.t','a9a.t','colon-cancer'};
    [b,A] = libsvmread(dataset{i});
    [m,n] = size(A);
    fprintf('name=%s, m=%d, n=%d, lambda=%.2f\n',dataset{i},m,n,lambda);

    % create function handle
    fun = @(x) lr_loss(A,b,m,x,lambda);
    progress_r = [];
    for repeat=1:5
        % set the initial point
        x0 = 4*(rand(n,1)-0.5);    % 2*(rand(n,1)-0.5)
       %% start comparison %%
        [T1,NFF1,NI1,G1] = IDFPM(fun,'IHCGPM',3,4,x0,para1);
        [T2,NFF2,NI2,G2] = UIDFPM(fun,'HCGPM',1,x0,para2);
        [T3,NFF3,NI3,G3] = UIDFPM(fun,'EPM',2,x0,para3);
        progress_r = [progress_r;NI1,NFF1,T1,G1,NI2,NFF2,T2,G2,NI3,NFF3,T3,G3];
    end
    TM = mean(progress_r);
    fprintf(fid_tex,'%s & %d & %d & %.1f/%.1f/%.3f/%.2e & %.1f/%.1f/%.3f/%.2e & %.1f/%.1f/%.3f/%.2e\\\\ \r\n',...
                dataset{i},m,n,TM);%NI1,NFF1,T1,G1,NI2,NFF2,T2,G2); 
%     fprintf(fid_tex,'%s & %d & %d & %.1f/%.1f/%.3f/%.2e & %.1f/%.1f/%.3f/%.2e\n& %.1f/%.1f/%.3f/%.2e & %.1f/%.1f/%.3f/%.2e\\\\ \r\n',...
%                 dataset{i},m,n,NI1,NFF1,T1,G1,NI2,NFF2,T2,G2,NI3,NFF3,T3,G3,NI4,NFF4,T4,G4); 

end
%% close file
fclose(fid_tex);