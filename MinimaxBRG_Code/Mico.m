function [Mico] = Mico(Pre, Post, Te1, MMBRGB, w, k)

% __________________________________________________________________________________________________________________________________
%|                                                                                                                                  |
%|                                       This function is to compute Mico of a minimax-BRG                                          |
%|__________________________________________________________________________________________________________________________________|

C=Post-Pre;
%[~, n]=size(C);
CI=C;
CI(:,Te1)=[];
[m,nI]=size(CI);  

MbM=[MMBRGB{:,2}];%%%% The set of all minimax basis markings
[~,num]=size(MbM); %%% num=|MbM|
Mico = [];
Mico_Marking = [];
%*************************************************************
%*****************Solving ILPPs*******************************
%*************************************************************

for q=1:num   
    Mb=MbM(:,q);
%******************Define variables y and Z*******
    y = intvar(nI,1,'full');  
    F = [w'*(CI*y+Mb)<=k];
    F = [F, CI*y+Mb>=zeros(m,1)];
    F = [F, y>=zeros(nI,1)];
    f=y;
%*************************************************************
%*******************Solving ILPPs*****************************
options = sdpsettings('verbose',3, 'solver','lpsolve');
sol = solvesdp(F, f, options);

if sol.problem == 0
%     Mico={value(y);Mb;Mb+CI*value(y)};
    Mico = [Mico; q];
    Mico_Marking = [Mico_Marking, Mb]; 
    continue
end
end 
% if Mico ~= []
[Mico_num, ~] = size(Mico);

Mico = [Mico];

% else 
%     fprintf('\n Mico is empty!\n');
% end
end
