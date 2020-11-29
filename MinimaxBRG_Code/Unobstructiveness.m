function [Unobs] = Unobs(MMBRG, Mico)

%***********************************************************************************
%***********************************************************************************
%***********************************************************************************
%***********This function is to test unobstructiveness of a minimax-BRG*************
%***********************************************************************************
%***********************************************************************************
%***********************************************************************************

[num, ~] = size (MMBRG);
A = zeros(num);
R = [];

%************Construcing the relationship matrix R***********************
for i= 1:num
R = [R; MMBRG{i, 4}];
end

[Rm, Rn] = size (R);


%************Construcing the adjacent matrix A of the minimax-BRG********
for j = 1: Rm
    for k = 1: Rn
        Rjk = [R{j, k}];
        [rm, ~] = size (Rjk);
             for h = 1:rm
                 rjk = [Rjk{h, :}{1,1}];
                 A(j, rjk) = 1;
             end
    end
end

        
A = [A];
G = digraph(A);

%***********Determine unobstructiveness of the minimax-BRG***************
[x, ~] = size(Mico);
for p = 1:num
    for q = 1:x
        Path = shortestpath(G,p,q);
        if Path == []
            continue
        else
            break
        end
    end
    if Path == []
        fprintf('\n The minimax-BRG is obstructed!\n The system is blocking!\n');
        Unobs = 1; 
        return
    end
end
if Path ~= []
    fprintf('\n The minimax-BRG is unobstructed!\n The system is non-blocking!\n');
    Unobs = 0;
end    
        
        
        
        
        
        



end