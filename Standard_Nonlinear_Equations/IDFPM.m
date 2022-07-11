% Matlab Model by Jianghua Yin (Jan.,2022, Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
%
%% the inertial derivative-free projection method (IDFPM) for solving 
%% constrained nonlinear pseudo-monotone equations of the form
%   F(x)=0, x\in C, 
% where C is a nonempty closed convex set.
%
function [Tcpu,NF,Itr,NormF] = IDFPM(NO,method,Switch,model,x0,para) 
 
format long

% start the clock
tic;

%% the number of itrations
% Itr=0;   

%% Initial information
[nprob,~]=init(NO);

%% the stopping criterion
epsilon=1e-6;
epsilon1=1e-7;

%% the line search parameters and relaxation factor
k_max = para.Itr_max;   % the maximum number of iterations
gamma = para.gamma;     % the initial guess
sigma = para.sigma;     % the coefficient of line search 
tau = para.tau;         % the compression ratio
% alpha = para.alpha;     % the coefficient of the inertial step
rho = para.rho;         % the relaxation factor 
alpha_try = 0.2;

fprintf('%s & %s & LSmodel=%d & gamma=%.4f & sigma=%.4f & tau=%.4f & Switch=%.4f & rho=%.4f\n', ... 
    nprob,method,model,gamma,sigma,tau,Switch,rho);

%% compute the search direction
Fx0 = feval(nprob,x0,1);   % evaluate the function value specified by nprob at x0
NF = 1;  
NormFx0 = norm(Fx0);                   
x0_old = x0;
L1 = 0;
     
for k=1:k_max
    
    if k==1 && NormFx0<=epsilon
        L1 = 1;
        NormF = NormFx0; % the final norm of equations
        break; 
    end
    if k==1
        alpha = alpha_try;
    else
        if Switch==1
            alpha = min(alpha_try,1/(norm(x0-x0_old)*k^2));
        elseif Switch==2
            alpha = min(alpha_try,1/(k*norm(x0-x0_old))^2);
        else
            alpha = alpha_try;
        end
    end
    %% compute the inertial step %%
    y0 = x0+alpha*(x0-x0_old);
    Fy0 = feval(nprob,y0,1);
    NF = NF+1;
    NormFy0 = norm(Fy0);
    if NormFy0<=epsilon
        L1 = 1;
        NormF = NormFy0;   % the final norm of equations
        break; 
    end
    
    %% compute the initial direction %%
    if k==1
        dk = -Fy0;
    else
        % update the search direction
        switch method
            case 'IGPM'
                dk = -Fy0; 
            case 'IHTTCGPM'
                w0 = Fy0-Fy0_old;
                NormFy0_old = norm(Fy0_old);
                Fy0tw0 = Fy0'*w0;
                Fy0tdk = Fy0'*dk;
                denominator = max(1.4*Normdk*norm(w0),NormFy0_old^2);
                betak = Fy0tw0/denominator;
                thetak = Fy0tdk/denominator;
                dk = -Fy0+betak*dk-thetak*w0;
            case 'IHCGPM'
                w0 = Fy0-Fy0_old;
                NormFy0_old = norm(Fy0_old);
                dktw0 = dk'*w0;
                Fy0tFy0_old = Fy0'*Fy0_old;
                numerator = NormFy0^2-max(0,NormFy0/NormFy0_old*Fy0tFy0_old);
                denominator = max(NormFy0^2,max(3*Normdk*NormFy0,dktw0));   
                betak = numerator/denominator;
                dk = -Fy0+betak*dk;
            otherwise
                disp('Input error! Please check the input method');
        end
    end
    Normdk = norm(dk);
    if Normdk<epsilon1
        L1 = 1;
        NormF = NormFy0;
        break;
    end
    Normdk2 = Normdk^2;
    Fy0_old = Fy0;
    
    %%% Start Armijo-type line search  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % model=1 means -F(zk)'*dk ¡Ý sigma*tk*norm(dk)^2
    % model=2 means -F(zk)'*dk ¡Ý sigma*tk*norm(F(zk))*norm(dk)^2
    % model=3 means -F(zk)'*dk ¡Ý sigma*tk*norm(F(zk))/(1+norm(F(zk)))*norm(dk)^2
    % model=4 means -F(zk)'*dk ¡Ý sigma*tk*max(lambda,min(nu,norm(Fz_new,2)))*norm(dk)^2
    if model==1
        t = gamma;
        z0_new = y0+t*dk;
        Fz0_new = feval(nprob,z0_new,1);
        NF = NF+1;
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = y0+t*dk;
            Fz0_new = feval(nprob,z0_new,1);
            NF = NF+1;
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
        NormFz0_new = norm(Fz0_new);
    elseif model==2
        t = gamma;
        z0_new = y0+t*dk;
        Fz0_new = feval(nprob,z0_new,1);
        NF = NF+1;
        NormFz0_new = norm(Fz0_new);
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*NormFz0_new*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = y0+t*dk;
            Fz0_new = feval(nprob,z0_new,1);
            NF = NF+1;
            NormFz0_new = norm(Fz0_new);
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
    elseif model==3
        t = gamma;
        z0_new = y0+t*dk;
        Fz0_new = feval(nprob,z0_new,1);
        NF = NF+1;
        NormFz0_new = norm(Fz0_new);
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*NormFz0_new/(1+NormFz0_new)*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = y0+t*dk;
            Fz0_new = feval(nprob,z0_new,1);
            NF = NF+1;
            NormFz0_new = norm(Fz0_new);
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
    else
        t = gamma;
        z0_new = y0+t*dk;
        Fz0_new = feval(nprob,z0_new,1);
        NF = NF+1;
        NormFz0_new = norm(Fz0_new);
        Fz0_newtdk = -Fz0_new'*dk;
        % check the Armijo-type line search condition
        while Fz0_newtdk < sigma*t*max(0.001,min(0.8,NormFz0_new))*Normdk2 && t>10^-6  
            % the Armijo-type line search condition violated
            t = t*tau;
            z0_new = y0+t*dk;
            Fz0_new = feval(nprob,z0_new,1);
            NF = NF+1;
            NormFz0_new = norm(Fz0_new);
            Fz0_newtdk = -Fz0_new'*dk;
        end %%% End Armijo-type line search %%%
    end 
    Fz0 = Fz0_new;
    NormFz0 = NormFz0_new;
%     if NormFz0<=epsilon
%         L1 = 1;
%         NormF = NormFz0; % the final norm of equations
%         break;
%     end
    xik = t*Fz0_newtdk/NormFz0^2;
    z1 = y0-rho*xik*Fz0;
    % compute the next iteration 
    x1 = feval(nprob,z1,2);
    Fx1 = feval(nprob,x1,1);
    NF = NF+1;
    NormFx1 = norm(Fx1);
    if NormFx1<=epsilon
        L1 = 1;
        NormF = NormFx1;
        break;
    end
    
    % update the iteration
    x0_old = x0;
    x0 = x1;
    NormFx0 = NormFx1;
end
if L1==1
    Itr = k;
    Tcpu = toc;
else
    NF = NaN;
    Itr = NaN;
    Tcpu = NaN;
    NormF = NaN;
end
