# Minimax-BRG

This is a repository for the paper named **"Verification of Nonblockingness in Bounded Petri Nets: A Novel Semi-Structural Approach"**.

Please see the PDF file named "Test_MinimaxBRG.pdf" for three additional benchmarks corresponding to the paper.

# Please see MinimaxBRG_Code directory for the codes of the paper.

The programs require Matlab R2017a or higher version.

We implement the key idea of the paper in MinimaxBRG.m (for computing the minimax-BRGs), MinimaxMbasis.m (for comptuting the minimax basis markings), and minimaxy.m (for computing the minimal and maximal explanations).

* To test and compare the computational efficiency between RG and minimax-BRG on specific Petri net benchmarks, one can call the function ``TestEfficiency.m`` in **program 1**

* To verify the nonblockingness of specific Petri net systems, one can call the function ``Nonblockingness.m`` in **program 2**

## Input of the program 1:

* the net system <N, M0> by its Pre matrix, Post matrix, and the initial marking M0

* the set of explicit transitions Te

## Output of the program 1:

* RG, minimax-BRG and their node numbers

* the times required to generate RG and minimax-BRG

#### The following is an example to run the program 1 by computing RG and minimax-BRG of the system in Fig. 1 (left) of the paper with \alpha = 1.

```MATLAB
%Pre matrix
         
Pre = [  %t1,t2,t3%
           1, 0, 0; %p1
           0, 1, 1; %p2
           0, 0, 1; %p3
];

%Post matrix
Post = [0, 1, 0;
        1, 0, 0;
        0, 0, 0;
];

%initial marking (one can change the token numbers)
M0 = [2; 0; 1];

%Explicit transition set Te = {t2}
Te1 = [2];

%To test the efficiency of RG and minimax-BRG
[TestEfficiency] = TestEfficiency(Pre, Post, M0, Te1);
```

## Input of the program 2:

* the Petri net system (N, M0, MF) by its Pre matrix, Post matrix, the initial marking M0

* the set of final markings MF characterizd by the generalized mutual exclusion constraint (GMEC) parameters w and k

* the set of explicit transitions Te

## Output of the program 2:

* the nonblockingness of the Petri net system (N, M0, MF)

* the time required w.r.t nonblockingness verification by using the minimax-BRG

#### The following is an example to run the program 2 by testing the nonblockingness of the system in Fig. 4 of the paper with \lambda = 6, \mu = 1, w = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 1; 1; 1; 1; 0; 0; 0; 0; 0; 0] and k = 3. 

```MATLAB
%Pre matrix
Pre = [  %t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16%
           1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0; %p1
           0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0; %p2
           0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p3
           0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p4
           0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p5
           0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p6
           0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p7
           0, 1, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0; %p8
           0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0; %p9
           0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0; %p10
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0; %p11
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0; %p12
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0; %p13
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0; %p14
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0; %p15
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1; %p16
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0; %p17
           0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 5, 0; %p18
           0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p19
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0; %p20
           0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; %p21
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0; %p22
]; 
        
%Post matrix
Post = [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
        2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0; 
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0; 
        0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
]; 

%initial marking (one can change the token numbers)
M0 = [6; 0; 0; 0; 0; 0; 0; 1; 1; 6; 0; 0; 0; 0; 0; 0; 1; 6; 1; 1; 1; 1];

%Explicit transition set Te = {t3, t6, t11, t13}
Te1 = [3 6 11 13];

%GMEC parameters w and k (characterizing the set of final markings MF)
w = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 1; 1; 1; 1; 0; 0; 0; 0; 0; 0];
k = 3;

%To verify the nonblockingness of the Petri net system
[Nonblockingness] = Nonblockingness(Pre, Post, M0, Te1, w, k);
```



