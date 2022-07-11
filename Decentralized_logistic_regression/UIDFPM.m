% Matlab Model by Jianghua Yin (Jan.,2022, Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
%
%% the inertial derivative-free projection method (DFPM) for solving 
%% constrained nonlinear pseudo-monotone equations of the form
%   F(x)=0, x\in C, 
% where C is a nonempty closed convex set.
%
function [Tcpu,NF,Itr,NormF] = UIDFPM(fun,method,model,x0,para) 
 
format long

% start the clock
tic;

%% the number of itrations
% Itr=0;   

%% the stopping criterion
epsilon = 1e-6;
epsilon1 = 1e-7;

%% the line search parameters and relaxation factor
k_max = para.Itr_max;   % the maximum number of iterations
gamma = para.gamma;     % the initial guess
sigma = para.sigma;     % the coefficient of line search 
tau = para.tau;         % the compression ratio
rho = para.rho;         % the relaxation factor 

fprintf('%s & LSmodel=%d & gamma=%.4f & sigma=%.4f & tau=%.4f & rho=%.4f\n', ... 
    method,model,gamma,sigma,tau,rho);

%% compute the search direction
Fx0 = feval(fun, x0);     % evaluate the function value specified by nprob at x0
NF = 1;                     % the total number of function evaluations
dk = -Fx0;
Normdk = norm(dk);
Normdk2 = Normdk^2;
NormFx0 = norm(Fx0);
L1 = 0;   
% LS = 0;    % the number of line search 
     
for k=1:k_max
    
    if k==1 && NormFx0<=epsilon
        L1 = 1;
        NormF = NormFx0;       % the final norm of equations
        break; 
    end
    
    %%% Start Armijo-type line search  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % model=1 means -F(zk)'*dk ¡Ý sigma*tk*norm(dk)^2
    % model=2 means -F(zk)'*dk ¡Ý sigma*tk*norm(F(zk))*norm(dk)^2
    % model=3 means -F(zk)'*dk ¡Ý sigma*tk*norm(F(zk))/(1+norm(F(zk)))*norm(dk)^2
    % model=4 means -F(zk)'*dk ¡Ý sigma*tk*max(lambda,min(nu,norm(Fz_new,2)))*norm(dk)^2
    if model==1
        t = gamma;
        z0_new = x0+t*dk;
%         LS = LS+1;
        Fz0_new = feval(fun, z0_new);
        NF = NF+1;
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = x0+t*dk;
%             LS = LS+1;
            Fz0_new = feval(fun, z0_new);
            NF = NF+1;
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
        NormFz0_new = norm(Fz0_new);
    elseif model==2
        t = gamma;
        z0_new = x0+t*dk;
%         LS = LS+1;
        Fz0_new = feval(fun, z0_new);
        NF = NF+1;
%         Normdk2 = norm(dk)^2;
        NormFz0_new = norm(Fz0_new);
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*NormFz0_new*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = x0+t*dk;
%             LS = LS+1;
            Fz0_new = feval(fun, z0_new);
            NF = NF+1;
            NormFz0_new = norm(Fz0_new);
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
    elseif model==3
        t = gamma;
        z0_new = x0+t*dk;
%         LS = LS+1;
        Fz0_new = feval(fun, z0_new);
        NF = NF+1;
        NormFz0_new = norm(Fz0_new);
%         Normdk2 = norm(dk)^2;
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*NormFz0_new/(1+NormFz0_new)*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = x0+t*dk;
%             LS = LS+1;
            Fz0_new = feval(fun, z0_new);
            NF = NF+1;
            NormFz0_new = norm(Fz0_new);
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
    else
        t = gamma;
        z0_new = x0+t*dk;
%         LS = LS+1;
        Fz0_new = feval(fun, z0_new);
        NF = NF+1;
        NormFz0_new = norm(Fz0_new);
%         Normdk2 = norm(dk)^2;
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*max(0.001,min(0.8,NormFz0_new))*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = x0+t*dk;
%             LS = LS+1;
            Fz0_new = feval(fun, z0_new);
            NF = NF+1;
            NormFz0_new = norm(Fz0_new);
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
    end 
    Fz0 = Fz0_new;
    NormFz0 = NormFz0_new;
    if model==2 && NormFz0<=epsilon
        L1 = 1;
        NormF = NormFz0; % the final norm of equations
        break;
    end
    NormFz02 = NormFz0^2;
    xik =  t*Fz0_newtdk/NormFz02;
    % compute the next iteration 
    x1 = x0-rho*xik*Fz0;
    Fx1 = feval(fun, x1);
    NF = NF+1;
    NormFx1 = norm(Fx1);
    if NormFx1<=epsilon
        L1 = 1;
        NormF = NormFx1;
        break;
    end
    % update the search direction
    switch method
        case 'GPM'
            dk = -Fx1;
        case 'HCGPM'
            % Sun M, Liu J. New hybrid conjugate gradient projection method for the convex constrained equations [J].
            % Calcolo, 2016, 53(3): 399-411.
            yk = Fx1-Fx0;
            NormF12 = NormFx1^2;
            betak = (NormF12-max(0,NormFx1/NormFx0*Fx1'*Fx0))/max(1.4*Normdk*NormFx1,dk'*yk);
            dk = -Fx1+betak*dk;
        case 'TTCGPM'
            yk = Fx1-Fx0;
            Fx1tyk = Fx1'*yk;
            Fx1tdk = Fx1'*dk;
            NormFx02 = NormFx0^2;
            betak = Fx1tyk/NormFx02;
            thetak = Fx1tdk/NormFx02;
            dk = -Fx1+betak*dk-thetak*yk;
        case 'EPM'
            % Liu, J.K., Lu, Z.L., Xu, J.L., et al.: An efficient 
            % projection-based algorithm without Lipschitz continuity for 
            % large-scale nonlinear pseudo-monotone equations. 
            % J. Comput. Appl. Math. {\bf 403}, 113822 (2022)
            yk = Fx1-Fx0;
            dktyk = dk'*yk;
            tk = 1+max(0,-dktyk/Normdk2);
            wk = yk+tk*dk;
            Fk1tdk = Fx1'*dk;
            wktdk = wk'*dk;
            betak = 0.6*Fk1tdk/wktdk;
            dk = -Fx1+betak*dk;
        otherwise
            disp('Input error! Please check the input method');
    end
    Normdk = norm(dk);
    if Normdk<epsilon1
        L1 = 1;
        NormF = norm(Fx1);
        break;
    end
    Normdk2 = Normdk^2;
    % update the iteration
    x0 = x1;
    NormFx0 = NormFx1;
    Fx0 = Fx1;
end
if L1==1
    Itr = k;
    Tcpu = toc;
else
    NF = NaN;
    Itr = NaN;
%     LS = NaN;
    Tcpu = NaN;
    NormF = NaN;
end
