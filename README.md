# Minimax-BRG

This is a repository for the paper named "Verification of Nonblockingness in Bounded Petri Nets: A Novel Semi-Structural Approach".

Please see the PDF file named "Test_MinimaxBRG.pdf" for three additional benchmarks corresponding to the paper.

# Please see MinimaxBRG_Code directory for the codes of the paper.

This program requires Matlab R2017a or higher version.

We implement the key idea of the paper in MinimaxBRG.m (for computing the minimax-BRGs), MinimaxMbasis.m (for comptuting the minimax basis markings), and minimaxy.m (for computing the minimal and maximal explanations).

To test the efficiency of the minimax-BRG on specific Petri net benchmarks, one can call the function Test.m

# Input of the program:

# 1. For computational efficiency comparison among RG, expanded BRG, and minimax-BRG:

● the net system <N, M0> by its Pre matrix, Post matrix, and the initial marking M0

● two sets of explicit transitions Te1 (for testing expanded BRG and minimax-BRG) and Te2 (for testing RG)


# 2. For nonblockingness verification by using minimax-BRG:

● the Petri net system (N, M0, MF) by its Pre matrix, Post matrix, the initial marking M0, the GMEC parameters w and k (characterizing the set of final markings MF)

● the set of explicit transitions Te1
