% Matlab Model by Jianghua Yin (Feb.,2022,Nanning)
% Copyright (C) 2022 Jian Group
% All Rights Reserved
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose and without fee is hereby
% granted, provided that the above copyright notice appear in all
% copies and that the copyright notice and this
% permission notice appear in all supporting documentation.                         


function out= problem8(x,mode)
% adapted from La Cruz, W., Raydan, M.: Nonmonotone spectral methods for large-scale nonlinear systems. Optim.
%Methods Softw. 18, 583¨C599 (2003)

n = length(x);
if mode==1
    out=log(abs(x)+1)-x/n;
elseif mode==2
    out=max(x,0);
end


    
        
    
    


