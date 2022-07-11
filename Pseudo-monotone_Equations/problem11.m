% Matlab Model by Jianghua Yin (Jul.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                          


function out= problem11(x,mode)
% A modification of Example 4.2 in ¡¶R-linear convergence analysis of inertial extragradient 
% algorithms for strongly pseudo-monotone variational inequalities¡·,Thong, D.V., Vuong, P.T., 
% J. Comput. Appl. Math. 2022, 406: 114003


if mode==1               % compute F(x)
  M = [1 0 -1;0 1.5 0;-1 0 2];
  out = (exp(-sum(x.^2))+2)*M*x;
elseif  mode==2          % compute the projection
    out = max(-5,min(x,5));
end

    
        
    
    


