function [B] = MinimaxBRG(Pre,Post,M0,Te1)

%BRG:  This function builds the minimax basis reachability graph of a PN net for given the set of explicit transitions Te.
%      
%      ********************************************************************
%                                 ## SYNTAX ##
%
%      [B] = MinimaxBRG(Pre,Post,M0,E)
%
%      Given a Petri net with its matrices Pre and Post,the initial marking
%      M0, and the row vector E,that indicates the set of explicit transitions,
%      this function returns a cell B that contains for each row:            
%      1) the node's number;
%      2) the basis markings that belong to the node;
%      3) the transitions enabled by the node;
%      4) the nodes that are reachable with the firing of any transition
%         in association with the j-vector correspondent.
%     
%         ______________________________________________________________________
%        |   1    |      2               |        3          |     4      |  5  |
%      T=|________|______________________|___________________|____________|_____|
%        |# Number|Minimax Basis Marking |Enabled Transitions|Arc-t Matrix| Tag |
%        |________|______________________|___________________|____________|_____|
%        |   6    | 
%        |________|
%        |  Arc_l |
%        | Matrix |
%        |________|
%
%      L must be a cell array that has as many rows as the cardinality of
%      the considered alphabet, that contains in each row the observable
%      transitions having the same label.
%      E=[2 3 6] means t2,t3,t6 are explicit transitions.
%
%      See also: showBRG

% Verify the input data

[m,n]=size(Post); % m is the number of places and n is the number of transitions
[c,p]=size(M0'); % c is the number of places (should equal to m) and p=1
% [sizeL,lenghtL]=size(L);

if (size(Post)==size(Pre))&(c==1)&(p==m),
elseif size(Post)~=size(Pre)
   fprintf('\n ERROR!! Matrices Pre and Post have different dimension!\n')
   fprintf('\n Put again the data\n')
else
   fprintf('\n  ERROR! dimensions of the marking are wrong!\n')
end

% if (lenghtL==1),
% else
%    fprintf('\n  ERROR! dimensions of the Matrix representing\n  the Labeling Function are wrong!\n')
% end

% if (b==1),
% else
%    fprintf('\n  ERROR! dimensions of the Matrix representing\n the Fault Class are wrong!\n')
% end

% if (size(L)==size(E)),
% else
%    fprintf('\n  ERROR! dimensions of the Matrix representing\n  the Symbol set is not consistent wrt\n  the Labeling function!\n')
% end

% Determine respectively the number of explicit transitions (no),
% and implicit transtions (nu)

no=size(Te1,2);    %%%%%no赋值为Te的cardinality,即explicit变迁的个数!
% for i=1:sizeL
%     [sizeLi,lenghtLi]=size(L{i,1});
%     no=no+lenghtLi;
% end

nu=n-no; %%%%implicit变迁的个数

% E' strettamente necessario ordinare le transizioni in maniera da avere
% rispettivamente prima quelle osservabili e successivamente le restanti
% non osservabili. Per congruenza con il MBRG faremo in maniera da avere
% le transizioni osservabili, quelle di guasto e per ultime le regolari.

MPre=[];
MPost=[];
% MF=[];
% ML=[];

% Vettore utilizzato in seguito per tenere traccia dell'originaria
% enumerazione delle transizioni.
% Es: if numbers(i)=j then la transizione tj ?stata numerata ti

numbers=zeros(1,n); %%%numbers为一个1行n列的全零行向量(为计算minimal expalnation做准备)

% Definizione di un vettore binario tale che
% if(reg(i)==1)
% then la transizione i-esima ?una transizione regolare.
% Infine un contatore utile per risettare le matrici definenti funzione di
% etichettatura e classi di guasto

rego=ones(1,n); %%%rego为一个1行n列的全1行向量 (其中n为所有变迁的个数)
count=0;
for i=1:no %%%%%%%%%no为explicit变迁的个数
    count=count+1; %%%%%%count=1, 2, ...
    t=Te1(i); %%%%%Te中的第i列元素赋值于t,也就是第i个explciit变迁
    rego(t)=0; %%%%%将1行n列全1行向量rego的第t列元素赋值为0
    numbers(count)=t;  %%%%%%将1行n列的全零行向量numbers中的第count列向量赋值为t
    MPre=[MPre,Pre(:,t)]; %%%%%%%Pre(:,t)是Pre的第t列向量
    MPost=[MPost,Post(:,t)];
    ME=1:count; %%%ME=1, 2, ..., count
end

for i=1:n
    if (rego(i)==1)
        count=count+1;
        numbers(count)=i;
        MPre=[MPre,Pre(:,i)];
        MPost=[MPost,Post(:,i)];
    end
end


Pre=MPre;
Post=MPost;

% Start the timer
%tic

% Initialize the BRG matrix T 初始化BRG矩阵

B=[{1} {[M0]} {[zeros(1,no)]} {[(empty_vector(no))]} {[0]}]; %%%B是由5个元胞数组(cell)组成的一行五列矩阵

c=cell2mat(B(:,5)); %%%%%%%%%%%将由五个数值数组组成的元胞数组B的第五列转换为一个数值数组,赋值于c
d=find(c==0); %%%%%%%将数组c中零元素的线性索引的向量赋值于d


% Since there is at least one node without TAG, it finds the coordinates of these nodes
% to explore and save them in the vector d

while ~isempty(d)   % when d is not empty 当d不为空时
	d=find(c==0);
	%For all observable transitions:
    for i=1:no
    
    % Per ciascuna delle marcature di base raggiungibili da Mcurrent con la
    % i-esima transizione Osservabile, a partire dalla prima marcatura non
    % esplorata MM e per ciascuno dei j-vector associati, definisco gli
    % archi del grafo.
    
        MM=B{d(1,1),2};
        %fprintf('Transizione ', i)
        Mb=MinimaxMbasis( Pre , Post ,MM , nu , i);
        %sizeMb21 is the number of basis markings reachable from MM
        [sizeMb21,lengthMb21]=size(Mb{2,1});
    
        for j=1:sizeMb21 %循环一次分析一个marking
            Nodeold=0;    
            Mcurrent=Mb{2,1}(j,:);
        
        % Verifichiamo  se le transizioni di guasto sono abilitate.
        % Questa funzione deve essere ricompilata per essere utilizzata su
        % MAC-OS
        
          %ftag=Cons(Pre , Post , Mcurrent' , nu , W , K);
        
        %Utilizzare questa nel caso in cui non si abbia la possibilit?di
        %farlo
        %Sol =faultclass(Pre , Post , Mcurrent' , nu , 0 ,F);
        
        % Verifichiamo il numero di J-Vector associati alla transizione
        % considerata
            [sizeJi,lenghtJi]=size(Mb{2,2}{j,1});
        
            for jj=1:sizeJi
                jcurrent=Mb{2,2}{j,1}(jj,:);
            % Ricordando che il riordinamento delle transizioni porta ad
            % avere un riordinamento anche del vettore di scatto della
            % giustificazione:
%             a=zeros(size(jcurrent));
%             for jc=1:nu
%                 a(numbers(no+jc)-no)=jcurrent(jc);
%             end
%             a

                a=[numbers(1,no+1:end);jcurrent];
                temp=sortrows(a')';%%%%%%对a矩阵元素升序排序
                jcurrent=temp(2,:);
            % Check that a transition is enabled or not
                if( ~isempty( find(Mcurrent<0) ) ) %%%%如果Mcurrent里非零元素不为空
                    B{d(1,1),3}(1,i)=0;
                    continue
        
            %Verification that a "loop" transition is not triggered unless the corresponding post is marked

            %%%%%elseif(max(Mcurrent'- Post(:,i))<0)
                elseif(min(Mcurrent'- Post(:,i))<0)
                    B{d(1,1),3}(1,i)=0;
                    continue
        
                else %se la transizione ?abilitata e porta ad una Mcurrent
%             fprintf('\n\nDalla marcatura ')
%             fprintf('%d ',MM)
%             fprintf ('\n alla marcatura ')
%             fprintf('%d ',Mcurrent)
%             fprintf('\ncon t%d e giuistificazione ',i)
%             fprintf('%d ',jcurrent)

                    [numofnode, lengthT]=size(B);

                % Verify that the marking is not already present in the graph
                    for k=1:numofnode
                        if(Mcurrent'==B{k,2})
                            B{d(1,1),3}(1,i)=1;
                            [sizej,lengthj]=size(B{d(1,1),4}{1,i});
                            B{d(1,1),4}{1,i}{sizej+1,1}={[k] [jcurrent]};
                            Nodeold=1;
%                             fprintf('\n\narco %d dal nodo %d al nodo %d con giustificazione',i,d(1,1),k)
%                             fprintf(' %d',jcurrent)
                        end            
                    end
                
               % If the marking is not already present, Nodeold == 0, add a new node
                
                
                    if(Nodeold==0) % create the new node
                        
                        [numofnode, lengthT]=size(B);
                        B{numofnode+1,1}=[numofnode+1];
                        B{numofnode+1,2}=[Mcurrent'];
                        %T{numofnode+1,3}= ftag;
                        A =empty_vector(n-nu);
                        B{numofnode+1,3}= zeros(1,no);
                        B{numofnode+1,4}= A;
                        B{numofnode+1,5}= 0;
                        
                    % Update the values of the considered node

                        B{d(1,1),3}(1,i)=1;
                    
                   % This function must be recompiled to be used on the MAC-OS
                    
                       %ftag2=Cons(Pre , Post , MM , nu , W , K);

                    %Sol2=faultclass(Pre , Post , MM , nu , 0 ,F);
                        
                        %T{d(1,1),3}=ftag2;
                        [sizej,lengthj]=size(B{d(1,1),4}{1,i});
                        B{d(1,1),4}{1,i}{sizej+1,1}={[numofnode+1] [jcurrent]};
                        B{d(1,1),5}= 0;
%                         fprintf('\n\narco %d dal nodo %d al nodo %d con giustificazione',i,d(1,1),numofnode+1)
%                         fprintf(' %d',jcurrent)
                        [numofnode, lengthT]=size(B);
                    end        
                end
            end
        end
    end

    B{d(1,1),5}= 1;

% Retrieve nodes not yet explored

    c=cell2mat(B(:,5));
    d=find(c==0);
end

% Insert the new array of arcs in column number 7 of the matrix T of the BRG

 [sizeT,lenghtT]=size(B);

% Genero l'array in cui inserire il vettore binario delle transizioni
% abilitate

% for n=1:sizeT
%     T{n,6}=zeros(1,sizeL);
% end
% 
%% For all the Minimax-BRG nodes
for n=1:sizeT		
	B{n,6}=empty_vector(no);
    % for all labels
    for i=1:no
%		[sizeLi,lenghtLi]=size(L{i,1});
%		% for the j-th transition belonging to the j-th class
        count=0;
%        for j=1:lenghtLi
            transition=ME(i);
			if((B{n,3}(1,transition))==1)
%				T{n,6}(1,i)=1;
                [sizeJi,lenghtJi]=size(B{n,4}{transition});
                for jj=1:sizeJi
                    count=count+1;
                    % {[symbol] [transition] {[arrival node] [j-vector]}}
                    B{n,6}{count,i}={[Te1(i)] [numbers(transition)] B{n,4}{1,transition}{jj,1}};
                end
			end
%		end
	end
end


%toc
%t=toc;
end