# Minimax-BRG

This is a repository for the paper named **"Verification of Nonblockingness in Bounded Petri Nets: A Novel Semi-Structural Approach"**.

Please see the PDF file named "Test_MinimaxBRG.pdf" for three additional benchmarks corresponding to the paper.

# Please see MinimaxBRG_Code directory for the codes of the paper.

The programs require Matlab R2017a or higher version.

We implement the key idea of the paper in MinimaxBRG.m (for computing the minimax-BRGs), MinimaxMbasis.m (for comptuting the minimax basis markings), and minimaxy.m (for computing the minimal and maximal explanations).

* To test and compare the computational efficiency among RG, expanded BRG, and minimax-BRG on specific Petri net benchmarks, one can call the function ``Test.m`` in **program 1**

* To verify the nonblockingness of specific Petri net systems, one can call the function ``Nonblockingness.m`` in **program 2**

## Input of the program 1:

* the net system <N, M0> by its Pre matrix, Post matrix, and the initial marking M0

* the set of explicit transitions Te1

## Output of the program 1:

* RG, expanded BRG, minimax-BRG and their node numbers

* the times required to generate RG, expanded BRG, and minimax-BRG

### The following is an example to run the program by testing the Minimax-BRG of the net system in Fig. 1 (left) of the paper with \alpha = 1.

```MATLAB
%Pre matrix
Pre = [   %t1,t2,t3%
     %p1%  1, 0, 0;
     %p2%  0, 1, 2;
     %p3%  0, 0, 1;
];

%Post matrix
Post = [0, 1, 0;
        1, 0, 0;
        0, 0, 0;
];

%initial marking (one can change the token numbers in p1 and p3)
M0 = [2; 0; 1];

%Explicit transition set Te = {t2}
Te1 = [2];

%To test the efficiency of RG, expanded BRG, and minimax-BRG based on the same Petri net benchmark
[TestEfficiency] = TestEfficiency(Pre,Post,M0,Te1);
```

## Input of the program 2:

* the Petri net system (N, M0, MF) by its Pre matrix, Post matrix, the initial marking M0

* the set of final markings MF characterizd by the GMEC parameters w and k

* the set of explicit transitions Te1

## Output of the program 2:

* the nonblockingness of the Petri net system (N, M0, MF)

* the time required w.r.t nonblockingness verification by using the minimax-BRG

### The following is an example to run the program by testing the Minimax-BRG of the net system in Fig. 1 (left) of the paper with \alpha = 1, w = [-1; 0; 0] and k = -2.

```MATLAB
%Pre matrix
Pre = [   %t1,t2,t3%
     %p1%  1, 0, 0;
     %p2%  0, 1, 2;
     %p3%  0, 0, 1;
];

%Post matrix
Post = [0, 1, 0;
        1, 0, 0;
        0, 0, 0;
];

%initial marking (one can change the token numbers in p1 and p3)
M0 = [2; 0; 1];

%Explicit transition set Te = {t2}
Te1 = [2];

%GMEC parameters w and k (characterizing the set of final markings MF)
w = [-1; 0; 0];
k = -2;

%To verify the nonblockingness of the Petri net system
[Nonblockingness] = Nonblockingness(Pre, Post, M0, Te1, w, k);
```



