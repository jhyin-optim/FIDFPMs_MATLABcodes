% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                          


function out= problem1(x,mode)
%Example 4.1 in ¡¶A Projection Method for a system of Nonlinear Monotone
%Equations with convex constraints¡·, C. Wang, Y. Wang, C. Xu, 2007

n = length(x);
if mode==1               % compute F(x)
  Fx=ones(n,1);
  for i=1:n
    Fx(i)=exp(x(i))-1;
  end
  out=Fx;
elseif  mode==2          % compute the projection
    out=max(x,0);
end

    
        
    
    


