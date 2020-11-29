function [B] =miny(Pre,Post,M,t,nu)

% miny: This function computes minimal explanations of a Petri net. A minimal
%       explanation is the smallest sequence of implicit transitions that
%       must have fired to explain an observation.
%       
%       *********************************************************************
%                               ## SYNTAX ##
%
%       [B] = miny(Pre,Post,M,t,nu)  
%       Given a Petri net with its matrices Pre and Post, a marking M, a
%       transition t and the number of implicit transitions nu, this
%       function returns a matrix B that contains in its rows the minimal 
%       explanations of the given net. 
%       The matrices Pre and Post have to contain in the early columns the
%       explicit transitions and then that implicit.



[p,tn]=size(Pre);
[x,c]=size(M);

% verification of the input data
if (size(Post)==size(Pre))&(c==1)&(p==x),
     elseif size(Post)~=size(Pre)
      fprintf('\n ERROR!! Matrices Pre and Post have different dimension!\n')
      fprintf('\n Put again the data\n')
     else
      fprintf('\n ERROR! dimensions of the  marking are wrong!\n')
end


%Incidence Matrix
C=Post-Pre;
%Incidence Matriz wrt implicit transition
Cu=(C(:,(tn-nu+1):tn));
%marking after firing of t
A=M-Pre(:,t); %%%%%%%%%%%%%%构造Cu',单位矩阵,A'以及全零行向量组成的矩阵Q
[nu,p]=size(Cu');
Q=[Cu' eye(nu);A' zeros(1,nu)];
[m,n]=size(Q);
[nu,p]=size(Cu');
S=Cu'; 
h=[];


while ~isempty(find(Q(nu+1:m,1:p)<0)) % if all the elements of matrix A are >= 0, come out of cycle (while)
   
  h=find(Q(nu+1:m,1:p)<0); %find the position of the element <0 in the matrix A
  [q,w]=size(h); % q=1, h is a row vector
  
  % choose the element of A < 0 in a random way 
  w1=w*rand+.001;
  w1=ceil(w1); %%%%%ceil(wl): 将 wl 的每个元素四舍五入到大于或等于该元素的最接近整数
  w1;
  if w1>w, w1=w; end;
  
 for j=w1:w1  % execute instructions of the "cycle for" for the chosen element
       
    o=h(q,j);
        
    u=ceil(o/(m-nu));% select the column where there is the element < 0
 
    i= o-((m-nu)*(u-1))+nu; % select the row where there is the element < 0

    y1=find(S(:,u)>0) ;  % y1 is the set containing the row's indices for which Cu'(i,j*)>0 (is the set I+)
   
    [l,g]=size(y1);


  if  isempty(y1) % if the set y1 is empty (y1 is the set I+ of the paper)
   Q(i,:)=[]; % delete the row i  
   [m,n]=size(Q);
            
   else  % if the set y1 is not empty
     for c=1:l
        
         f=y1(c,g); % select the elements of the column vector y1
          
         Z=[Q(i,:)]+[Q(f,:)]; %compute the new row to add to the matrix 
      
         Q=[Q ;Z]; %  add the new row (Z)
           
         [m,n]=size(Q);

     end
            Q(i,:)=[];
            [m,n]=size(Q);
            
    end
  end
end
  
  
% At the end of this cycle all the elements of A are >=0.
% Now I have to remove from B each row that cover another one.  
% The result will be the minimal explanations Ymin(M,t).

B = Q(nu+1:m,p+1:n); % B contains the explanations (now we check if they are minimal or not)

if   isempty (B) 
  % fprintf('transition t can^t be enabled by the given marking \n')
   B;
end

[s,t]=size(B);
m=1;
Z=zeros(m,1);
% starts the control to verify that the explanations found are minimal
for i=1:s
   for j=1:s
      if i~=j
      P=B(i,:)-B(j,:);
        
       if P>=0
         k=i; % row's indices of B to delete 
         
         Z(m,1)=k;
         m=m+1;
    
       end 
      end 
  end
end


if Z>0 
   B(Z(:,1),:)=[]; % delete the row that cover another one 
%   fprintf ('minimal explanations are:\n')
%   disp(B)
  else  if ~isempty(B) % if the explanations were already minimal (i.e. C=0)
%   fprintf ('minimal explanations are:\n')
%   disp(B)
  end
end
%if B==zeros(s,nu)
%    fprintf('that is transition chosen is enabled immediately by given \nmarking without the firing of unobservable transitions ')
  
end
% B;