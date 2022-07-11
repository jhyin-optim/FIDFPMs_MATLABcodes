# FIDFPMs_MATLABcodes
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
% methods for constrained nonlinear pseudo-monotone equations with applications. 
%Submitted in Computational and Applied Mathematics.

% If you use/modify this code, please cite the just-mentioned paper appropriately.

% -----------------------------------------------------------------------
% Copyright (2022): Jianghua Yin
% ----------------------------------------------------------------------
%
% The first version of this code by Jianghua Yin, Dec., 16, 2019

% model=1 means -F(zk)'*dk ≥ sigma*tk*norm(dk)^2

% model=2 means -F(zk)'*dk ≥ sigma*tk*norm(F(zk))*norm(dk)^2

% model=3 means -F(zk)'*dk ≥ sigma*tk*norm(F(zk))/(1+norm(F(zk)))*norm(dk)^2

% model=4 means -F(zk)'*dk ≥ sigma*tk*max(lambda,min(nu,norm(Fz_new,2)))*norm(dk)^2
