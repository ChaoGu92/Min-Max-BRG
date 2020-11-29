function [B] =ally_0229(Pre,Post,M,t,nu)

% ally: This function computes minimal and maximal explanations of a Petri net.
%       
%       *********************************************************************
%                               ## SYNTAX ##
%
%       [B] = ally(Pre,Post,M,t,nu)  
%       Given a Petri net with its matrices Pre and Post, a marking M, a
%       transition t and the number of implicit transitions nu, this
%       function returns a matrix B that contains in its rows the minimal and maximal
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
           
         [m,~]=size(Q);

     end
            Q(i,:)=[];
            [m,~]=size(Q);
            
    end
  end
end
  
[m,n]=size(Q);

%*************************************************************************************
%*************Begin of the Computation of Y(M,t) (later we compute Ymax(M,t))*********
%*************************************************************************************
VarA=m; %rows number of matrix Q;
VarB=0;
nuog = nu;
while VarA ~= VarB
    iii=1;
    VarB = VarA;
    %*********new code******
    R = zeros(nuog*(VarA-nu),n);%***预分配
    %***********************
    while iii < nuog*(VarA-nu)
          for k1 = 1:nuog   
              for k2 = (nu+1):VarA                                    
              RN = [Q(k2,:)]+[Q(k1,:)]; 
              R(iii,:) = RN;
              iii = iii+1;
              end
          end
    end
 
    R = unique(R,'rows');
    %Now I remove the rows with negative elements
    [nunew,~]=size(R);
    id=[];
    for k3 = 1:nunew
        jd =~ all(R(k3,:)>=0);
        if jd == 1
           id = [id;k3];
        end
    end
    R(id,:)=[];
%Qnew=unique(Q(nu+1:m,p+1:n),'rows');
% Qnew=unique(Q(nu+1:m,:),'rows');
    Qnew = unique([[Q(nuog+1:VarA,:)];R],'rows','stable');
    Q = [Q(1:nuog,:);Qnew];
%     Q=unique(Q,'rows');
 [m1,~] = size(Q); 
 VarA = m1;
 nu = VarB;
    

end
  
B = Q(nuog+1:m1,p+1:n);

%if B==zeros(s,nu)
%fprintf('that is transition chosen is enabled immediately by given \nmarking without the firing of unobservable transitions ')
end
% B;