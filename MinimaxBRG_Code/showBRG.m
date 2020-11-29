function showBRG(B)

%showBRG: This function shows Basis Reachability Graph of a P/T System.
%        
%         *****************************************************************
%                               ## SYNTAX ##
%
%         showBRG(T)
%          This function shows how obtain a Petri Net's Basis Reachability
%          Graph T step-by-step starting from the initial node and
%          following all enabled labels and relative reached nodes.
%
%         See also: MBRG, BRG, BRD, showMBRG, showBRD, diagnosability



% Verifies that the number of input arguments to the function is equal to one. 
% If such is not the case, an error message is returned. 

ni=nargin;
error(nargchk(1,1,ni));

% Reading of the number of nodes (n) and the number of observable transitions (t)

n=B{end,1};

[sizeL,LenghtL]=size(B{1,6});
t=0;
for f=1:n
    for ff=1:LenghtL
        [sizeL,LenghtL]=size(B{f,6});
        for fff=1:sizeL
            if(size(B{f,6}{fff,ff})==[0 0])
                continue
            else
                tt=B{f,6}{fff,ff}{1,2};
                    if(tt>t)
                        t=tt;
                    end
            end
        end
    end
end    
        

% Number of digits useful to the enumeration of the markings (ncifre) and
% the transitions (tcifre).
% [As an example, if we have 100 markings, we would be interested in enumerating
% the initial marking as MØØ rather than MØ]

ncifre= ceil(log10(n));
tcifre= ceil(log10(t));

% Computation of the number of places of the net
[p,uno]=size(B{1,2});

% Visualization of the number of nodes of the BRG

fprintf('\n Minimax Basis Reachability Graph node''s number n = %d\n\n',n)

for f=1:n % for all the markings
    
    % Computation of the number of labels (LenghtL) and the maximum number of
    % transitions associated with a label (sizeL).
    [sizeL,LenghtL]=size(B{f,6});
    
    % Visualization of the current marking
    
    fprintf('\n#\t\b Marking M')
    
    if(f-1<10)
        for zz=1:ncifre-1
            fprintf('0')
        end
    elseif(f-1<100)
        for zz=1:ncifre-2
            fprintf('0')
        end
    elseif(f-1<1000)
        for zz=1:ncifre-3
            fprintf('0')
        end
    elseif(f-1<10000)
        for zz=1:ncifre-4
            fprintf('0')
        end
    end        
    fprintf('%d=[',f-1)
    for ff=1:p
        fprintf('%d ',B{f,2}(ff,1))
    end
    fprintf('\b]''\t\b')
   
    % Visualization of the transitions enabled at the considered marking
    % and the relative justification vector
    
    noarc=1;    
    
    fprintf('\n\n \t\b Explicit transitions enabled to fire:\n\t\b')
    
    for ff=1:LenghtL
        for fff=1:sizeL
            [a,b]=size(B{f,6}{fff,ff});
            if a~=0
                noarc=0;
                l=B{f,6}{fff,ff}{1,1};
                t=B{f,6}{fff,ff}{1,2};
                n_next=B{f,6}{fff,ff}{1,3}{1};
                fprintf('  %s(t',l)
                
                if(t-1<10)
                    for zz=1:tcifre-1
                        fprintf('0')
                    end
                elseif(t-1<100)
                    for zz=1:tcifre-2
                        fprintf('0')
                    end
                elseif(t-1<1000)
                    for zz=1:tcifre-3
                        fprintf('0')
                    end
                elseif(t-1<10000)
                    for zz=1:tcifre-4
                        fprintf('0')
                    end
                end
                
                fprintf('%d) -> M',t)
                
                if(n_next-1<10)
                    for zz=1:ncifre-1
                        fprintf('0')
                    end
                elseif(n_next-1<100)
                    for zz=1:ncifre-2
                        fprintf('0')
                    end
                elseif(n_next-1<1000)
                    for zz=1:ncifre-3
                        fprintf('0')
                    end
                elseif(n_next-1<10000)
                    for zz=1:ncifre-4
                        fprintf('0')
                    end
                end

                fprintf('%d:\t\b e=[',n_next-1)
                [u,v]=size(B{f,6}{fff,ff}{1,3}{2});
                if v==0
                    fprintf(' ]\n')
                else
                    for c=1:v
                        fprintf('%d ',B{f,6}{fff,ff}{1,3}{2}(1,c))
                    end
                    fprintf('\b]\n')
                end
            end
        end
        
    end

    % We verify that there exist output arcs from the node
    if noarc==1
        fprintf('\t\b  None\n\t\b')
    end
    
    fprintf('\n\t\t*******\n')

end

% fprintf('\nShow Basis Reachability Graph:\n')
% disp(T)
