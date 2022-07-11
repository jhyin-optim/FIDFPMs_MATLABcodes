% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
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

% set random number seed
rng(2016)

ITR_max = 2000;
% setup TXT document
fid_tex=fopen('mytext.txt','w'); 
% problem_set = 1:72;
problem_set = [5:9 14:18 23:27 32:36 41:45 50:54 59:63 68:72];
% set parameters
np = length(problem_set); % from problem 1 to problem 8 % the number of the test problems
ns = 4;   % the number of the test algorithms
T = zeros(np,ns);
F = zeros(np,ns);
N = zeros(np,ns);

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

% run
for index=1:np
    Num = problem_set(index);
    [name,n] = init(Num);
    progress_r = [];
    for repeats = 1:5
        if (Num<=27 && Num>=23)
            x0 = 2*rand(n,1)-1;
        else
            x0 = 4*rand(n,1);   % x0\in (0,10). x0 = 4*rand(n,1)时间占优，但有一个问题不可解
        end
        [T1,NFF1,NI1,G1] = IDFPM(Num,'IHCGPM',1,4,x0,para1); % acceleration
        [T2,NFF2,NI2,G2] = IDFPM(Num,'IHCGPM',2,4,x0,para1);
        [T3,NFF3,NI3,G3] = IDFPM(Num,'IHCGPM',3,4,x0,para1);
        [T4,NFF4,NI4,G4] = UIDFPM(Num,'HCGPM',1,x0,para2);
%         [T5,NFF5,NI5,G5] = UIDFPM(Num,'EPM',2,x0,para3);
        progress_r = [progress_r;NI1,NFF1,T1,G1,NI2,NFF2,T2,G2,NI3,NFF3,T3,G3,NI4,NFF4,T4,G4];%,NI5,NFF5,T5,G5];
    end
    TM = mean(progress_r);
    fprintf(fid_tex,'%s %d & %.1f/%.1f/%.3f/%.2e & %.1f/%.1f/%.3f/%.2e\n& %.1f/%.1f/%.3f/%.2e & %.1f/%.1f/%.3f/%.2e\\\\ \r\n', ... 
                name,n,TM);
    T(index,:) = [TM(3),TM(7),TM(11),TM(15)];%,TM(19)]; 
    F(index,:) = [TM(2),TM(6),TM(10),TM(14)];%,TM(18)];
    N(index,:) = [TM(1),TM(5),TM(9),TM(13)];%,TM(17)]; 
    %G(index,:) = [TM(4),TM(8),TM(12),TM(16)];%,TM(20)]; 
end
%% 关闭文件
fclose(fid_tex);

%% 画图
clf;   %clf删除当前图形窗口中、
       %%句柄未被隐藏(即它们的HandleVisibility属性为on)的图形对象
figure(1);
%subplot(2,2,1);
perf(T,'logplot');
%title('时间性能');
%set(gca,'ylim',[0.3,1]);
xlabel('\tau','Interpreter','tex');
ylabel('\rho(\tau)','Interpreter','tex');
legend('IHCGPM1','IHCGPM2','IHCGPM3','HCGPM','Location','southeast');
% %subplot(2,2,2);
figure(2);
perf(F,'logplot');
%title('目标函数计算性能');
% set(gca,'ylim',[0.1,1]);
xlabel('\tau','Interpreter','tex');                     %% 给x轴加注
ylabel('\rho(\tau)','Interpreter','tex');               %% 给y轴加注
legend('IHCGPM1','IHCGPM2','IHCGPM3','HCGPM','Location','southeast');
%subplot(2,2,3);
figure(3);
perf(N,'logplot');
%title('迭代次数性能');
%set(gca,'ylim',[0.5,1]);
xlabel('\tau','Interpreter','tex');
ylabel('\rho(\tau)','Interpreter','tex');
legend('IHCGPM1','IHCGPM2','IHCGPM3','HCGPM','Location','southeast');
% %hold on
% %text
% %axes
% %set(gca,'xtick',[],'ytick',[]) 
% %figure(2);
% %perf(T,'logplot');% 此“logplot”任何一个确定的常数都可以，只要保证有两个输入变量