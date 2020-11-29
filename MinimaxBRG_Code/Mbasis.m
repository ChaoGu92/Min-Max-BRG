function [ Mw ] = Mbasis(Pre , Post , M0, nu , w )


%  Mbasis: This function computes for any observation w, a set, that we
%          denote M(w), whose elements are couple of basis marking and
%          relative j-vectors
%          ****************************************************************
%
%                                  ## SYNTAX ##
%          [ Mw ] = Mbasis(Pre, Post, M0, nu, w)
%          Given a Petri net with its matrices Pre and Post, a initial
%          marking M0, a firing sequence of observable transition w and the
%          number of  unobservable transitions nu, this function returns a
%          cell-matrix Mw that contents many row as the length of the 
%          firing sequence +1, and for each row, three columns.
%          The first column is a matrix that represents the basis marking
%          consistent with the firing transition which is represented in 
%          the third column. The second column of each row is an other
%          cell-matrix of one column where, the number of row is equal
%          to the number of  basis marking for this transition. 
%          In each row of is sub cell-matrix there is a matrix that
%          represents the set of j-vectors corresponding to the basis
%          marking in the first column.
%          The firing sequence w must be a row array of integer where each
%          number represents the relative observable transition.
%          The matrices Pre and Post must contain in the first columns the
%          observable transitions and then that unobservable.


  
 [sizew,lenghtw]=size(w); 
 [pn,tn]=size(Pre);
 [x,c]=size(M0);

 % verification of the input data
if (size(Post)==size(Pre))&(c==1)&(pn==x),
elseif size(Post)~=size(Pre)
        fprintf('\n ERROR!! Matrices Pre and Post have different dimension!\n')
        fprintf('\n Insert again the data\n')
else
        fprintf('\n ERRORE! dimensions of the  marking are wrong!\n')
        return
end

if(sizew~=1)
    fprintf('\n ERROR! w must be a row array\n')
    return
end          
 
C=Post-Pre;
Cu=(C(:,(tn-nu+1):tn));

% Inizializzazione della Matrice dati. Prima riga corrispondente alla
% marcatura iniziale, giustificazione nulla corrispondente alla parola
% vuota e parola vuota stessa (indicata con pedice nullo).
% Sia M(w)={M0 0}.
Mw = {M0' {zeros(1,nu)} [0]};

% Per ciascuna delle transizioni appartenenti alla parola data
for t=1:lenghtw
    % Prelevo la transuizione da far scattare
    transition=w(t);
    Mw{t+2,2}=[];
    
    % Ad ogni nuova transizione,  svuoto l'insieme delle marcature
    % raggiunte con la parola w't a partire dall'insieme delle marcature
    % del passo preendente
    M=[];
    JNEW=[];
    Jnew=[];
    % 'm' ?il numero di basis marking in Mw corrispondenti w',
    % (dove w=w't t=w(j) )
    Mold=Mw{t,1};
    [sizeMold,lenghtMold]= size(Mold);
    
    % Per ciascuna delle m marcature di base raggiunte con w'    
    for i=1:sizeMold
        % verifico il numero r di vettori di giustificazione che gli
        % corrispondono.
        Mold_i=Mold(i,:);
        Jold=Mw{t,2}{i,1};
        [sizeJold,lenghtJold]= size(Jold);
        

        
        % Calcolo tutte le giustificazioni possibili per la transizione
        % j-esima.
        % 'B' ?una matrice di dimensioni [c x d] dove: 'c' ?il numero di
        % giustificazioni e 'd' il numero di transizioni non osservabili.
%***********************************************************************
          Jcurrent =miny(Pre,Post,Mold_i',transition,nu); 
%          Jcurrent =[Jcurrent; onlymax(Pre,Post,Mold_i',transition,nu)]; 
%***********************************************************************
%         Jcurrent =onlymax_0120(Pre,Post,Mold_i',Te,transition,nu);
        [sizeJcurrent,lenghtJcurrent]= size(Jcurrent);
        % Se B ?una matrice vuota, allora la transizione j-esima non ?
        % abilitata dalla marcatura in analisi.
        if ( isempty(Jcurrent))
            % Impongo che sia un vettore nullo come se la transizione fosse
            % abilitata senza l'ausilio di transizioni non osservabili
            Jcurrent=zeros(1,nu); 
        end
        
        % Per tutte le giustificazioni minime calcolate per lo scatto di
        % t-j,
        for g=1:sizeJcurrent
            Jcurrent_g=Jcurrent(g,:);
            % calcolo le marcature raggiunte con lo scatto delle
            % giustificazioni stesse e la transizione j-esima in analisi.
            
            %****************************NB********************************
            %
            % 1) Si faccia attenzione al fatto che in questa maniera
            %    vengono abilitate anche tutte quelle transizioni "cappio"
            %    nonostante il posto corrispondente non sia marcato.
            % 2) Si noti che la richiesta di scatto di transizioni non
            %    abilitate, porterebbe alla scrittura di marcature
            %    negative, invece che all'uscita anzitempo del programma.
            %
            %   Di tutti questi errori ?tenuto conto nelle funzioni BRG ed
            %   MBRG.
            %
            %****************************NB********************************
            
            HIT =0;
            Mcurrent = Mold_i + (Cu*Jcurrent_g')' + (C(:,transition))';
            Jnew=[];
            for k=1:sizeJold
                Jnew(k,:)=Jold(k,:)+Jcurrent_g;
            end
            
            % Verifico se la Marcatura Mcurrent sia presente nell'insieme M
            % delle marcature marcature consistenti con w'
            [sizeM,lenghtM]= size(M);
            
            % Se l'insieme delle marcature consistenti con w' ?un insieme
            % vuoto, allora lo iniziualizziamo pari ad Mcurrent
            if sizeM==0
                M=Mcurrent;
                JNEW{1,1}=Jnew;
                
            % in caso contrario, verifichiamo che la marcatura sia gi?
            % stata raggiunta in passato
            else
                for k=1:sizeM
                    if Mcurrent==M(k,:)
                        HIT=1;
                        JNEW{k,1}=[JNEW{k,1};Jnew];
                        break
                    end
                end
                
                if HIT ==0
                    M(end+1,:)=Mcurrent;
                    JNEW{end+1,1}=Jnew;
                end
            end
            [sizeM,lenghtM]= size(M);
        end
    end
    
    % Per ogni marcatura consistente con la parola w' ?necessario
    % eliminare le giustificazioni ridondanti:
    [sizeM,lenghtM]= size(M);
    % Per tutti i gruppi di giustificazioni
    for i=1:sizeM
        % Per tutte le giustificazioni presenti nel gruppo scelto
        [sizetemp,lenghttemp]= size(JNEW{i,1});
        for ii=1:sizetemp

            if ii> sizetemp
                break
            end
            
            temp=JNEW{i,1}(ii,:);
            
            for iii=sizetemp:-1:1
                if temp==JNEW{i,1}(iii,:) & ii~=iii
                    JNEW{i,1}(iii,:)=[];
                end
            end
            
            [sizetemp,lenghttemp]= size(JNEW{i,1});
        
        end
    end
    
    % Registro l'insieme delle marcature raggiunte, le giustificazioni ed
    % il suffisso w' corrispondente
    Mw{t+1,1}=M;
    Mw{t+1,2}=JNEW;
    Mw{t+1,3}=[Mw{t,3},transition];
end

Mw=Mw(1:length(Mw)-1,:);   

end

