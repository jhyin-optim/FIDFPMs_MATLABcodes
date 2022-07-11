% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                             


function out= problem6(x,mode)
% Example 1 in Gao P, He C. An efficient three-term conjugate gradient method for nonlinear monotone equations with convex constraints[J]. 
% Calcolo, 2018, 55(4): 53.

n = length(x);
if mode==1
  Fx=ones(n,1);
  for i=1:n
    Fx(i)=(exp(x(i)))^2+3*sin(x(i))*cos(x(i))-1;
  end
  out=Fx;
elseif  mode==2
    out=max(x,0);
end

    
        
    
    


