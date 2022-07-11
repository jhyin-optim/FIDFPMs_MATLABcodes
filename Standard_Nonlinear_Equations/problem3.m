% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                           


function out= problem3(x,mode)
%Problem 2 in ¡¶Spectral Gradient Projection Method for solving Nonlinear
% Equations with Convex Constraints¡·, Z.S. Yu, J. Lin, J. Sun, Y.H. Xiao, L.Y. Liu, Z.H. Li 2009

n = length(x);
if mode==1
    out=x-sin(abs((x)-1));
elseif mode==2
    if sum(x)<=n && min(x)>=-1 
        out=x;
    else
        out=quadprog(speye(n),-x,ones(1,n),n,[],[],-ones(n,1));
        %out=quadprog(eye(n),-x,[ones(1,n);zeros(n-1,n)],[n;zeros(n-1,1)],[],[],-1*ones(n,1),[]);
    end
end


    
        
    
    


