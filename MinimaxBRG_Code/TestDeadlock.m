function [TestDeadlock] = TestDeadlock(MA,Pre,w,k)
%**************************************************************************
%**************This function is to test deadlocks in essential markings****************
%**************************************************************************

[~,num]=size(MA); %%% num=|MbM|
[~,n]=size(Pre);
logic=0;
MAD=[];
for i=1:num
    for j=1:n
logic=~isempty(find([MA(:,i)-Pre(:,j)]<0));
if logic==1
    continue
else
    MAD=[MAD,MA(:,i)];
end
    end
end
TestDeadlock=[setdiff(MA',MAD', 'rows')]';


%********************Test if non-final*****************
[~,num]=size(TestDeadlock); %%% num=|MbM|
Test=0;
for i=1:num
if w'*TestDeadlock(:,i)>=k+1
    TestDeadlock = TestDeadlock(:,i);
    fprintf('The system contains non-final deadlock!\n The system is blocking!\n');
    Test = Test+1;
    return
else
    continue
end
end
if Test==0
   TestDeadlock = [];
   fprintf('The system contains no non-final deadlock!\n'); 
end
end