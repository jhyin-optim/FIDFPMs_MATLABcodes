% Matlab Model by Jianghua Yin (Jul.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.      

% This is a demo of DFPM for solving constrained nonlinear pseudo-monotone equations
% equations of the form
%   F(x)=0, x\in C, 
% where C is a nonempty closed convex set.

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

% model=1 means -F(zk)'*dk ≥ sigma*tk*norm(dk)^2
% model=2 means -F(zk)'*dk ≥ sigma*tk*norm(F(zk))*norm(dk)^2
% model=3 means -F(zk)'*dk ≥ sigma*tk*norm(F(zk))/(1+norm(F(zk)))*norm(dk)^2
% model=4 means -F(zk)'*dk ≥ sigma*tk*max(lambda,min(nu,norm(Fz_new,2)))*norm(dk)^2

clc;
clear all
close all

% % set random number seed
% rng(2016)

ITR_max = 2000;
% setup TXT document
fid_tex=fopen('mytext.txt','w'); 
% problem_set = 1:20;
problem_set = [1:8 15:20];
% set parameters
np = length(problem_set); % the number of the test problems from Problem 9 to Problem 11 
ns = 3;   % the number of the test algorithms
T = zeros(np,ns);
F = zeros(np,ns);
N = zeros(np,ns);

% set parameters for inertial derivative-free projection methods (IDFPMs)
para1.Itr_max = ITR_max;
para1.gamma = 1;         % the initial guess
para1.sigma = 1;         % the coefficient of line search 
para1.tau = 0.5;         % the compression ratio
% para1.alpha = 0.015;       % the coefficient of inertial step
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

% run
for index=1:np
    Num = problem_set(index);
    [name,x0] = init(Num);
    [T1,NFF1,NI1,G1] = IDFPM(Num,'IHCGPM',3,4,x0,para1); % acceleration
    [T2,NFF2,NI2,G2] = UIDFPM(Num,'HCGPM',1,x0,para2);
    [T3,NFF3,NI3,G3] = UIDFPM(Num,'EPM',2,x0,para3);
    fprintf(fid_tex,'%s & %d/%d/%.3f/%.2e & %d/%d/%.3f/%.2e & %d/%d/%.3f/%.2e\\\\ \r\n', ... 
                name,NI1,NFF1,T1,G1,NI2,NFF2,T2,G2,NI3,NFF3,T3,G3);
    T(index,:) = [T1,T2,T3];
    F(index,:) = [NFF1,NFF2,NFF3];
    N(index,:) = [NI1,NI2,NI3];
    %G(index,:) = [G1,G2,G3];
end
%% 关闭文件
fclose(fid_tex);

% %% 画图
% clf;   %clf删除当前图形窗口中、
%        %%句柄未被隐藏(即它们的HandleVisibility属性为on)的图形对象
% figure(1);
% %subplot(2,2,1);
% perf(T,'logplot');
% %title('时间性能');
% %set(gca,'ylim',[0.3,1]);
% xlabel('\tau','Interpreter','tex');
% ylabel('\rho(\tau)','Interpreter','tex');
% legend('IHCGPM1','IHCGPM2','IHCGPM3','HCGPM','Location','southeast');%,'DY+','HZ','location','best');%% 'CG\_descent'
% % %subplot(2,2,2);
% figure(2);
% perf(F,'logplot');
% %title('目标函数计算性能');
% % set(gca,'ylim',[0.1,1]);
% xlabel('\tau','Interpreter','tex');                     %% 给x轴加注
% ylabel('\rho(\tau)','Interpreter','tex');               %% 给y轴加注
% legend('IHCGPM1','IHCGPM2','IHCGPM3','HCGPM','Location','southeast');%,'DY+','HZ','location','best');%% 线分类说明'JHS','DHS','VHS','JPRP','DPRP','JHS','DHS',
% %subplot(2,2,3);
% figure(3);
% perf(N,'logplot');
% %title('迭代次数性能');
% %set(gca,'ylim',[0.5,1]);
% xlabel('\tau','Interpreter','tex');
% ylabel('\rho(\tau)','Interpreter','tex');
% legend('IHCGPM1','IHCGPM2','IHCGPM3','HCGPM','Location','southeast');%,'DY+','HZ','location','best'); %'JFR','PRP',
% % %hold on
% % %text
% % %axes
% % %set(gca,'xtick',[],'ytick',[]) 
% % %figure(2);
% % %perf(T,'logplot');% 此“logplot”任何一个确定的常数都可以，只要保证有两个输入变量