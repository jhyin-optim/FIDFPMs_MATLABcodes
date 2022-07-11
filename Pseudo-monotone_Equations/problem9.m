% Matlab Model by Jianghua Yin (Jul.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                          


function out= problem9(x,mode)
%Example 6.7 in ¡¶Single projection method for pseudo-monotone variational 
% inequality in Hilbert spaces¡·,Shehu, Y., Dong, Q.L., Jiang, D., Optimization 2019, 68(1), 385-409

if mode==1               % compute F(x)
  Fx = ones(2,1);
  Fx(1) = (x(1)^2+(x(2)-1)^2)*(1+x(2));
  Fx(2) = -x(1)^3-x(1)*(x(2)-1)^2;
  out = Fx;
elseif  mode==2          % compute the projection
    out = max(-10,min(x,10));
end

    
        
    
    


