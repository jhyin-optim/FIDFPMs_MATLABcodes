% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                     


function out= problem7(x,mode)
% adapted from W. La Cruz. A spectral algorithm for large-scale systems of nonlinear 
%monotone equations. Numerical Algorithms, 76(4):1109-1130, 2017.

if mode==1
    out=2*x-sin(abs(x));
elseif mode==2
    out=max(x,0);
end


    
        
    
    


