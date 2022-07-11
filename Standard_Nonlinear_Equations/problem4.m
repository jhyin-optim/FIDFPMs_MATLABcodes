% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                             


function out= problem4(x,mode)
% Example 4 in Gao P, He C. An efficient three-term conjugate gradient method for nonlinear monotone equations with convex constraints[J]. 
% Calcolo, 2018, 55(4): 53.

n = length(x);
if mode==1
  Fx=ones(n,1);
  Fx(1)=2*x(1)+sin(x(1))-1;
  for i=2:n-1
    Fx(i)=2*x(i-1)+2*x(i)+sin(x(i))-1;
  end
  Fx(n)=2*x(n)+sin(x(n))-1;
  out=Fx;
elseif  mode==2
    out=max(x,0);
end

    
        
    
    


