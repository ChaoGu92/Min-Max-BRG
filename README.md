# Minimax-BRG

This is a repository for the paper named "Verification of Nonblockingness in Bounded Petri Nets: A Novel Semi-Structural Approach".

Please see the PDF file named "Test_MinimaxBRG.pdf" for three additional benchmarks corresponding to the paper.

# Please see MinimaxBRG_Code directory for the codes of the paper.

This program requires Matlab R2017a or higher version.

We implement the key idea of the paper in MinimaxBRG.m (for computing the minimax-BRGs), MinimaxMbasis.m (for comptuting the minimax basis markings), and minimaxy.m (for computing the minimal and maximal explanations).

To test the efficiency of the minimax-BRG on specific Petri net benchmarks, one can call the function Test.m

# Input of the program:

# 1. for computational efficiency comparison among RG, expanded BRG, and minimax-BRG:

● the net system <N, M0> by its Pre matrix, Post matrix, and the initial marking M0

● two sets of explicit transitions Te1 (for testing expanded BRG and minimax-BRG) and Te2 (for testing RG)


# 2. for nonblockingness verification by using minimax-BRG:

● the Petri net system (N, M0, MF) by its Pre matrix, Post matrix, the initial marking M0, and the GMEC parameters w and k (characterizing the set of final markings MF)

● the set of explicit transitions Te1

# Output of the program:

# 1. 

● RG, expanded BRG, minimax-BRG and their node numbers

● the times required to generate RG, expanded BRG, and minimax-BRG

# 2. 

● the nonblockingness of the Petri net system (N, M0, MF)

● the time required w.r.t nonblockingness verification by using the minimax-BRG


public static void main(String[] args) {
   	//Pre matrix
   	int[][] Pre = {
   			     /*t1,t2,t3,t4,t5,t6,t7,t8,t9*/
   			/*p1*/{1, 0, 0, 0, 0, 0, 0, 0, 0},
   			/*p2*/{0, 1, 0, 0, 0, 0, 0, 0, 0},
   			/*p3*/{0, 0, 1, 0, 0, 0, 0, 0, 0},
   			/*p4*/{0, 0, 0, 2, 0, 0, 0, 1, 0},
   			/*p5*/{0, 0, 0, 0, 1, 0, 0, 0, 0},
   			/*p6*/{0, 0, 0, 0, 0, 2, 0, 0, 0},
   			/*p7*/{0, 0, 0, 0, 0, 0, 2, 0, 0},
   			/*p8*/{0, 0, 0, 0, 0, 0, 0, 0, 1},
   	};
   	//Post matrix
   	int[][] Post = {
   			{0,0,0,0,0,0,0,0,1},
   			{1,0,0,0,0,0,1,0,0},
   			{0,1,0,0,0,0,0,0,0},
   			{0,0,1,0,0,0,1,0,0},
   			{0,0,0,2,0,0,0,0,0},
   			{0,0,0,0,1,0,0,0,0},
   			{0,0,0,0,0,2,0,0,0},
   			{0,0,0,0,0,0,0,1,0},
   	};
   	//initial marking (one can change the token numbers in p1 and p7)
   	int[] M0 = {1,//p1
   	            0,0,0,0,0,
   	            2,//p7
   	            0};
   	// observable transition set To={t2,t4,t6,t7,t9}
   	List<String> To = Arrays.asList("t2","t4","t6","t7","t9");
   	// primary observable transition Tpri = {t4,t6,t9}
   	List<String> Tpri = Arrays.asList("t4","t6","t9");
   	
   	//To test the efficiency of HBRG
   	testHBRG(Pre, Post, M0, To, Tpri) ;
   }
