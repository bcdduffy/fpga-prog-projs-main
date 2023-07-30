////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    comparator_continuous_bdeduffy.v
// Author:      Brenden Duffy
// Date:        25 Feb 2022
// Version:     1
// Description: This file contains a continuous assignment model for the Part 2 of Project2B.
//              It uses continuous assignment rather than primitive gates.
////////////////////////////////////////////////////////////////////////////////////////////////////

module comparator_continuous_bdeduffy(valA, valB, aGTb, aGEb, aLTb, aLEb, aEQb, aNEb);
   input  [2:0] valA, valB;
   output       aGTb, aGEb, aLTb, aLEb, aEQb, aNEb;                   // Inpus denoting different comparisons between the two numbers

	assign aGTb = (valA > valB);

	assign aGEb = (valA >= valB);

	assign aLTb = (valA < valB);

	assign aLEb = (valA <= valB);

	assign aEQb = (valA == valB);

	assign aNEb = (valA != valB);



endmodule
