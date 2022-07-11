% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                            


function out= problem2(x,mode)
%Example 3 in ¡¶Three derivative-free projection methods for nonlinear monotone
% equations with convex constraints¡·, Min Sun, Jing Liu, 2015

n = length(x);
if mode==1
  Fx=ones(n,1);
  Fx(1)=x(1)-exp(cos((x(1)+x(2))/(n+1)));
  for i=2:n-1
    Fx(i)=x(i)-exp(cos((x(i-1)+x(i)+x(i+1))/(n+1)));
  end
  Fx(n)=x(n)-exp(cos((x(n-1)+x(n))/(n+1)));
  out=Fx;
elseif  mode==2
    out=max(x,0);
end

    
        
    
    


