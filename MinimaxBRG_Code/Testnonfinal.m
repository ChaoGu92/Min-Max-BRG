function [MEfinal] = Testnonfinal(TestDeadlock,w,k)
%**************************************************************************
%**************This function is to test if all essential markings are final****************
%**************************************************************************

[~,num]=size(TestDeadlock); %%% num=|MbM|
Test=0;
for i=1:num
if w'*TestDeadlock(:,i)>=k+1
    fprintf('The system contains non-final deadlock!\n The system is blocking!\n');
    Test=Test+1;
    return
else
    continue
end
end
if Test==0
   fprintf('The system contains no non-final deadlock!\n'); 
end
MEfinal=Test;
end