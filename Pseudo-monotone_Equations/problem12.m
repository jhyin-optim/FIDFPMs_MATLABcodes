% Matlab Model by Jianghua Yin (Jul.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                          


function out= problem12(x,mode)
%Example 1 in ¡¶Solving pseudomonotone variational inequalities and 
% pseudoconvex optimization problems using the projection neural network¡·,Hu, X., Wang, J., 
% IEEE Trans. Neural Networks 2006, 17(6): 1487-1499

if mode==1               % compute F(x)
  Fx=ones(4,1);
  Fx(1) = sum(x)-4*x(2)*x(3)*x(4);
  Fx(2) = sum(x)-4*x(1)*x(3)*x(4);
  Fx(3) = sum(x)-4*x(1)*x(2)*x(4);
  Fx(4) = sum(x)-4*x(1)*x(2)*x(3);
  out=Fx;
elseif mode==2          % compute the projection
    out=max(1,min(x,5));
end

    
        
    
    


