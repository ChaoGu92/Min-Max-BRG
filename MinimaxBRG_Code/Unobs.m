function [Unobs] = Unobs(MMBRG, Mico)

%***********************************************************************************
%***********************************************************************************
%***********************************************************************************
%***********This function is to test unobstructiveness of a minimax-BRG*************
%***********************************************************************************
%***********************************************************************************
%***********************************************************************************


[num, ~] = size (MMBRG);

if length(Mico) == num %all minimax-basis markings are i-coreachable
    %fprintf('\n The minimax-BRG is unobstructed!\n The system is non-blocking!\n');
    Unobs = [0];
    return
end
    

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
NUM = [1:num]';
NUM (Mico) =[];
[number, ~] = size (NUM);
[x, ~] = size(Mico);



for p = 1:number
    for q = 1:x
        Path = shortestpath(G,NUM(p),Mico(q));
        TF = isempty(Path);
        if TF == 1
            continue
        else
            break
        end
    end
    TF = isempty(Path);
        if TF == 1
        %fprintf('\n The minimax-BRG is obstructed!\n The system is blocking!\n');
        Unobs = [1]; 
        return
    end
end
TF = isempty(Path);
if TF == 0
    %fprintf('\n The minimax-BRG is unobstructed!\n The system is non-blocking!\n');
    Unobs = [0];
else
    %fprintf('\n The minimax-BRG is obstructed!\n The system is blocking!\n');
    Unobs = [1]; 
end    
end