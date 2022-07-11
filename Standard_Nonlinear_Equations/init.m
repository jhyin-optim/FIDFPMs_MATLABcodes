% init 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [nprob,n,m,x0]=initf(nprob)
% This function sets n,m, and the standard starting    
% point based on the nprob and returns it to initpt     
% function.                                                                                                    
% Created on 10/30/94 by Madhu Lamba                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [nprob,n] = init(NO)

%global FIRSTIME

switch NO
    %% nprob='problem1';
      case 1
        nprob='problem1';
        n=1000;
    
    %% nprob='problem1';
      case 2
        nprob='problem1';
        n=3000;
        
    %% nprob='problem1';
      case 3
        nprob='problem1';
        n=5000;
        
    %% nprob='problem1';
      case 4
        nprob='problem1';
        n=8000;
    
    %% nprob='problem1';
      case 5
        nprob='problem1';
        n=10000;

    %% nprob='problem1';
      case 6
        nprob='problem1';
        n=30000;
    
    %% nprob='problem1';
      case 7
        nprob='problem1';
        n=50000;
        
    %% nprob='problem1';
      case 8
        nprob='problem1';
        n=80000;
        
    %% nprob='problem1';
      case 9
        nprob='problem1';
        n=100000;
        
    %% nprob='problem2';
      case 10
        nprob='problem2';
        n=1000;
    
    %% nprob='problem2';
      case 11
        nprob='problem2';
        n=3000;
        
    %% nprob='problem2';
      case 12
        nprob='problem2';
        n=5000;
        
    %% nprob='problem2';
      case 13
        nprob='problem2';
        n=8000;
    
    %% nprob='problem2';
      case 14
        nprob='problem2';
        n=10000;
        
    %% nprob='problem2';
      case 15
        nprob='problem2';
        n=30000;
    
    %% nprob='problem2';
      case 16
        nprob='problem2';
        n=50000;
        
    %% nprob='problem2';
      case 17
        nprob='problem2';
        n=80000;
        
    %% nprob='problem2';
      case 18
        nprob='problem2';
        n=100000;

    %% nprob='problem3';
      case 19
        nprob='problem3';
        n=1000;
    
    %% nprob='problem3';
      case 20
        nprob='problem3';
        n=3000;
        
    %% nprob='problem3';
      case 21
        nprob='problem3';
        n=5000;
        
    %% nprob='problem3';
      case 22
        nprob='problem3';
        n=8000;
    
    %% nprob='problem3';
      case 23
        nprob='problem3';
        n=10000;
        
    %% nprob='problem3';
      case 24
        nprob='problem3';
        n=30000;
    
    %% nprob='problem3';
      case 25
        nprob='problem3';
        n=50000;
        
    %% nprob='problem3';
      case 26
        nprob='problem3';
        n=80000;
        
    %% nprob='problem3';
      case 27
        nprob='problem3';
        n=100000;

    %% nprob='problem4';
      case 28
        nprob='problem4';
        n=1000;
    
    %% nprob='problem4';
      case 29
        nprob='problem4';
        n=3000;
        
    %% nprob='problem4';
      case 30
        nprob='problem4';
        n=5000;
        
    %% nprob='problem4';
      case 31
        nprob='problem4';
        n=8000;
    
    %% nprob='problem4';
      case 32
        nprob='problem4';
        n=10000;

    %% nprob='problem4';
      case 33
        nprob='problem4';
        n=30000;
        
    %% nprob='problem4';
      case 34
        nprob='problem4';
        n=50000;
        
    %% nprob='problem4';
      case 35
        nprob='problem4';
        n=80000;
    
    %% nprob='problem4';
      case 36
        nprob='problem4';
        n=100000;    

    %% nprob='problem5';
      case 37
        nprob='problem5';
        n=1000;
    
    %% nprob='problem5';
      case 38
        nprob='problem5';
        n=3000;
        
    %% nprob='problem5';
      case 39
        nprob='problem5';
        n=5000;
        
    %% nprob='problem5';
      case 40
        nprob='problem5';
        n=8000;
    
    %% nprob='problem5';
      case 41
        nprob='problem5';
        n=10000;

    %% nprob='problem5';
      case 42
        nprob='problem5';
        n=30000;
        
    %% nprob='problem5';
      case 43
        nprob='problem5';
        n=50000;
        
    %% nprob='problem5';
      case 44
        nprob='problem5';
        n=80000;
    
    %% nprob='problem5';
      case 45
        nprob='problem5';
        n=100000;

    %% nprob='problem6';
      case 46
        nprob='problem6';
        n=1000;
    
    %% nprob='problem6';
      case 47
        nprob='problem6';
        n=3000;
        
    %% nprob='problem6';
      case 48
        nprob='problem6';
        n=5000;
        
    %% nprob='problem6';
      case 49
        nprob='problem6';
        n=8000;
    
    %% nprob='problem6';
      case 50
        nprob='problem6';
        n=10000;
       
    %% nprob='problem6';
      case 51
        nprob='problem6';
        n=30000;
        
    %% nprob='problem6';
      case 52
        nprob='problem6';
        n=50000;
        
    %% nprob='problem6';
      case 53
        nprob='problem6';
        n=80000;
    
    %% nprob='problem6';
      case 54
        nprob='problem6';
        n=100000;
        
    %% nprob='problem7';
      case 55
        nprob='problem7';
        n=1000;
    
    %% nprob='problem7';
      case 56
        nprob='problem7';
        n=3000;
        
    %% nprob='problem7';
      case 57
        nprob='problem7';
        n=5000;
        
    %% nprob='problem7'; 
      case 58
        nprob='problem7';
        n=8000;
    
    %% nprob='problem7';
      case 59
        nprob='problem7';
        n=10000;
        
    %% nprob='problem7'; cuter
      case 60
        nprob='problem7';
        n=30000;
        
    %% nprob='problem7'; cuter
      case 61
        nprob='problem7';
        n=50000;
        
    %% nprob='problem7'; 
      case 62
        nprob='problem7';
        n=80000;
    
    %% nprob='problem7';
      case 63
        nprob='problem7';
        n=100000;

    %% nprob='problem8';
      case 64
        nprob='problem8';
        n=1000;
    
    %% nprob='problem8';
      case 65
        nprob='problem8';
        n=3000;
        
    %% nprob='problem8';
      case 66
        nprob='problem8';
        n=5000;
        
    %% nprob='problem8';
      case 67
        nprob='problem8';
        n=8000;
    
    %% nprob='problem8';
      case 68
        nprob='problem8';
        n=10000;

    %% nprob='problem8';
      case 69
        nprob='problem8';
        n=30000;
        
    %% nprob='problem8';
      case 70
        nprob='problem8';
        n=50000;
        
    %% nprob='problem8';
      case 71
        nprob='problem8';
        n=80000;
    
    %% nprob='problem8';
      case 72
        nprob='problem8';
        n=100000;
end