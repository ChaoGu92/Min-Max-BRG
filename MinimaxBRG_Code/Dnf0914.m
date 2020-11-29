function [Dnf] = Dnf0914(Pre,Post,Te1,MMBRG,w,k)

%**************************************************************************
%**************This function is to determine if there "exist" non-final markings (not compute)**********
%**************************************************************************
%**************************************************************************



[m,~] = size(Post);
Pre1 = [zeros(m,1),Pre];%%%%%Set fake implicit transition t1 with Pre(~,t1)=0;
Post1 = [zeros(m,1),Post];%%%%%Set fake implicit transition t1 with Post(~,t1)=0;
C = Post1-Pre1;
% [m,~]=size(C);
CI = C;
TeOG = Te1;
[~, te] = size(TeOG);


Te1 = Te1+1;
Te1 = [1,Te1];
CI(:,Te1) = [];
% [~,nu]=size(CI);  

MbM = [MMBRG{:,2}];%%%% The set of all minimax basis markings
[~,num] = size(MbM); %%% num=|MbM|
t = 1;
% YB=[];
Mall = [];
for i = 1:num
YB = m0212(Pre1,Post1,MbM(:,i),Te1,t);
[yb,~] = size(YB);
for j = 1:yb
%     if [MbM(:,i)+CI*(YB(j,:))']>=zeros(1,m)
Mall = MbM(:,i)+CI*(YB(j,:))';

%**************************************
%[~,n] = size(Pre);
%logic = 0;
Dnf = []; 
%MAD = [];
    for p = 1:te
logic =~isempty(find([Mall-Pre(:,TeOG(p))]<0));
if logic == 1
    continue
else
%     logic = 0;
%     MAD = [MAD,Mall];
break
end
    end
    %*****test if it is non-final****
if (logic == 1) && (w'*Mall>=k+1)
    Dnf = Mall;
    %fprintf('\n The system contains non-final deadlock!\n The system is blocking!\n');
    return
else
    continue
end
%************************************    




%     end
end
end

TF_Dnf = isempty(Dnf);
if TF_Dnf == 1
   %fprintf('\n The system contains no non-final deadlock!\n'); 
end
%MA = [unique(Mall', 'rows')]';

%**************************************************************************
%*********This sub-routine test if the above markings are dead markings******************
%**************************************************************************
 %%% num=|MbM|

%**************************************************************************
%**************This sub-routine is to test if all the above dead markings are final****************
% %**************************************************************************
% 
% [~,num] = size(TestDeadlock); %%% num=|MbM|
% Test = 0;
% for i = 1:num
% if w'*TestDeadlock(:,i)>=k+1
%     Dnf = TestDeadlock(:,i);
%     fprintf('\n The system contains non-final deadlock!\n The system is blocking!\n');
%     Test = Test+1;
%     return
% else
%     continue
% end
% end
% if Test == 0
%    Dnf = [];
%    fprintf('\n The system contains no non-final deadlock!\n'); 
% end




end