% init 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [nprob,n,m,x0]=initf(nprob)
% This function sets n,m, and the standard starting    
% point based on the nprob and returns it to initpt     
% function.                                                                                                    
% Created on 10/30/94 by Madhu Lamba                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [nprob,x0] = init(NO)

%global FIRSTIME

switch NO
    %% nprob='problem9';
      case 1
        nprob='problem9';
        x0 = [10;10];
        
    %% nprob='problem9';
      case 2
        nprob='problem9';
        x0 = [-10;-10];  
        
    %% nprob='problem9';
      case 3
        nprob='problem9';
        x0 = [1;1];
        
    %% nprob='problem9';
      case 4
        nprob='problem9';
        x0 = [-1;-1];
        
    %% nprob='problem9';
      case 5
        nprob='problem9';
        x0 = [0.1;0.1];
        
    %% nprob='problem9';
      case 6
        nprob='problem9';
        x0 = [1;0.5];
        
    %% nprob='problem9';
      case 7
        nprob='problem9';
        x0 = [0.5;1];
        
    %% nprob='problem9';
      case 8
        nprob='problem9';
        x0 = [0.5;0];
        
    %% nprob='problem10';
      case 9
        nprob='problem10';
        x0 = [0;0;0;0];
        
    %% nprob='problem10';
      case 10
        nprob='problem10';
        x0 = [5;5;5;5];
        
    %% nprob='problem10';
      case 11
        nprob='problem10';
        x0 = [0.1;0.1;0.1;0.1];
        
    %% nprob='problem10';
      case 12
        nprob='problem10';
        x0 = [1;0.5;1/3;0.25];
        
    %% nprob='problem10';
      case 13
        nprob='problem10';
        x0 = [0.25;0.5;0.75;1];
        
    %% nprob='problem10';
      case 14
        nprob='problem10';
        x0 = [0.75;0.5;0.25;0];
        
    %% nprob='problem11';
      case 15
        nprob='problem11';
        x0 = [1;1;1];
        
    %% nprob='problem11';
      case 16
        nprob='problem11';
        x0 = [-1;-1;-1];
        
    %% nprob='problem11';
      case 17
        nprob='problem11';
        x0 = [0.1;0.1;0.1];
        
    %% nprob='problem11';
      case 18
        nprob='problem11';
        x0 = [1;0.5;1/3];
        
    %% nprob='problem11';
      case 19
        nprob='problem11';
        x0 = [1/3;2/3;1];
        
    %% nprob='problem11';
      case 20
        nprob='problem11';
        x0 = [2/3;1/3;0];
    
end