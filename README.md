# Minimax-BRG

This is a repository for the paper named "Verification of Nonblockingness in Bounded Petri Nets: A Novel Semi-Structural Approach".

Please see the PDF file named "Test_MinimaxBRG.pdf" for three additional benchmarks corresponding to the paper.

# Please see MinimaxBRG_Code directory for the codes of the paper.

This program requires Matlab R2017a or higher version.

We implement the key idea of the paper in MinimaxBRG.m (for computing the minimax-BRGs), MinimaxMbasis.m (for comptuting the minimax basis markings), and minimaxy.m (for computing the minimal and maximal explanations).

* To test and compare the computational efficiency among RG, expanded BRG, and minimax-BRG on specific Petri net benchmarks, one can call the function ``Test.m``

* To verify the nonblockingness of specific Petri net systems, one can call the function ``Nonblockingness.m``

## Input of the program:

### 1. for computational efficiency comparison among RG, expanded BRG, and minimax-BRG:

* the net system <N, M0> by its Pre matrix, Post matrix, and the initial marking M0

* two sets of explicit transitions Te1 (for testing expanded BRG and minimax-BRG) and Te2 (for testing RG)


### 2. for nonblockingness verification by using minimax-BRG:

* the Petri net system (N, M0, MF) by its Pre matrix, Post matrix, the initial marking M0, and the GMEC parameters w and k (characterizing the set of final markings MF)

* the set of explicit transitions Te1

## Output of the program:

### 1. for computational efficiency comparison among RG, expanded BRG, and minimax-BRG:

* RG, expanded BRG, minimax-BRG and their node numbers

* the times required to generate RG, expanded BRG, and minimax-BRG

### 2. for nonblockingness verification by using minimax-BRG:

* the nonblockingness of the Petri net system (N, M0, MF)

* the time required w.r.t nonblockingness verification by using the minimax-BRG


```MATLAB
//Pre matrix
Pre = [1 0 0;
       0 1 2;
       0 0 1];

//Pre matrix
Post = [0 1 0;
        1 0 0;
        0 0 0];

//initial marking (one can change the token numbers in p1 and p3)
M0 = [2;0;1];

//Explicit transition set Te = {t2}
Te1 = [2];

//GMEC parameters w and k (characterizing the set of final markings MF)
w = [-1;0;0];
k = -2;
```

