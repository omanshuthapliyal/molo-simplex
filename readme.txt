IE 630: Final Project

Disclaimer: Two phase simplex implementation in simplex.m to solve a general 
LP are due to https://github.com/iamboorrito/Two-Phase-Simplex-Algorithm

Code contains comments, wherever possible, and used the intermediate 
LPs required to solve the 3 phases, also in comments.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CODE COMPONENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main_IMRT.m : calls other scripts to setup the IMRT problem
|
|-- setup.m : sets up the parameters for matrices C, A, and b
| |
| |-- collimator.m : sets up collimator parameters
|    |
|    |-- dosageMatrix.m : function to calculate matrices J's
|
|-- phase1.m : finds the first BFS
|   |
|   |-- simplex.m : Simplex algorithm implementation
|       |          [SIMPLEX.M taken from Github and cited]
|       |-- rsimplex.m 
|       |-- pivot.m      [dependent functions]
|       |-- findMinRation.m 
|
|-- phase2.m : constructs first efficient BFS
|
|-- phase3.m : generate efficient BFSs
|
main_v2.m : 
Validates the MultiObjective Simplex solver from Phase I, Phase II, 
and Phase III against the recommended problem with 2^n efficient 
solutions [from "Multicriteria Optimization", by Matthias Ehrgott].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INSTRUCTIONS TO RUN THE CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1. Change MATLAB's current directory to the zipped folder
2. Run main_IMRT.m for the IMRT problem
	2.1 Enter choice '1' for user defined parameters
		2.1.1 MATLAB prompts to enter parameters for density, radiation
		absorption coefficients, and dosage levels (s_N, s_o, d_T).
		2.1.2 Geometric parameters are hidden from the user and hard coded.
	2.2 Enter '0' for default parameters
3. main_v2.m validates MOLO Simplex on the MOLO problem with 
   2^p efficient solutions