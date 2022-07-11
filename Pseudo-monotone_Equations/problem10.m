% Matlab Model by Jianghua Yin (Jul.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                          


function out= problem10(x,mode)
%Example 1 in ¡¶Solving pseudomonotone variational inequalities and 
% pseudoconvex optimization problems using the projection neural network¡·,Hu, X., Wang, J., 
% IEEE Trans. Neural Networks 2006, 17(6): 1487-1499

Q = [5 -1 2 0;-1 5 -1 3;2 -1 3 0;0 3 0 5];
a = [1;-2;-2;1];
b = [2;1;1;0];
if mode==1               % compute F(x) 
    out = ((b'*x+20)*(2*Q*x+a)-(x'*Q*x+a'*x-2)*b)/(b'*x+20)^2;
elseif mode==2          % compute the projection
    out = max(0,min(x,10));
end

    
        
    
    


