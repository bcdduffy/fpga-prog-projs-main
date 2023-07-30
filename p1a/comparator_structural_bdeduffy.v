////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    comparator_structural_bdeduffy.v
// Author:      Brenden Duffy
// Date:        31 Jan 2021
// Version:     1
// Description: This file contains a structural model for the Part 2 of Project1A.
//              It uses primitive logic gates.
////////////////////////////////////////////////////////////////////////////////////////////////////

module comparator(valA, valB, aGTb, aGEb, aLTb, aLEb, aEQb, aNEb);
   input  [2:0] valA, valB;
   output       aGTb, aGEb, aLTb, aLEb, aEQb, aNEb;                   // Inpus denoting different comparisons between the two numbers
   wire 	valA0_n, valA1_n, valA2_n, valB0_n, valB1_n, valB2_n; 	// Wires for inverted inputs of A and B
   wire		c1r1, c1r2, c1r3, c1r4, c1r5, c1r6, c1r7;
   wire		c2r1, c2r2; 
   wire 	c1r7n;
   wire		c3r1, c3r2, c3r3, c3r4, c3r5;


   //wire 	valA0_n, valA1_n, valA2_n, valB0_n, valB1_n, valB2_n; 	// Decoder inputs: C is the MSB; A is the LSB.
   //wire 	c1row1, c1row2,  c1row3, c1row4, c1row5, c1row6;
   //wire 	c1row1a, c1row2a, c1row3a;
   //wire 	c2row1, c2row2, c2row3, c2row4, c2row5, c2row6;
   //wire 	equals, greater, less;


   not not1(valA0_n, valA[0]), not2(valA1_n, valA[1]), not3(valA2_n, valA[2]), not4(valB0_n, valB[0]), not5(valB1_n, valB[1]), not6(valB2_n, valB[2]);

   xnor xnor1(c1r1, valB[1], valA[1]), xnor2(c1r2, valB[2], valA[2]), xnor3(c1r6, valB[0], valA[0]);
   
   and and1(c1r3, valB[0], valA0_n), and2(c1r4, valB[2], valA2_n), and3(c1r5, valB[1], valA1_n), and4(c1r7, valB0_n, valA[0]);

   not not7(c1r7n, c1r7);

   and and5(c2r1, c1r1, c1r2), and6(c2r2, c1r2, c1r5);

   and and7(c3r1, c2r1, c1r3), and8(aEQb, c2r1, c1r6), and9(c3r4, c2r1, c1r7n);

   xnor xnor4(c3r2, c1r4, c2r2);

   or or1(c3r5, c1r4, c2r2);

   xnor xnor5(aGTb, c3r4, c3r5), xnor6(aLTb, c3r1, c3r2);

   not not8(aNEb, aEQb);

   or or3(aGEb, aEQb, aGTb), or4(aLEb, aEQb, aLTb);


   //not not1(valA0_n, valA[0]), not2(valA1_n, valA[1]), not3(valA2_n, valA[2]), not4(valB0_n, valB[0]), not5(valB1_n, valB[1]), not6(valB2_n, valB[2]);

   //xor xor1(c1row1a, valA[0], valB[0]), xor2(c1row2a, valA[1], valB[1]), xor3(c1row3a, valA[2], valB[2]);

   //and and1(c1row1, valA[2], valB2_n), and2(c1row2, valA[1], valB1_n), and3(c1row3, valA[0], valB0_n), 
	//and4(c1row4, valA2_n, valB[2]), and5(c1row5, valA1_n, valB[1]), and6(c1row6, valA0_n, valB[0]);

   //and and7(aEQb, c1row1a, c1row2a, c1row3a);

   //and and8(c2row1, c1row2a, c1row1), and9(c2row3, c1row1a, c1row3), and10(c2row5, c1row1a, c1row5), and11(c2row6, c1row2a, c1row6);

   //or or1(aGTb, c2row1, c1row2, c2row3), or2(aLTb, c1row4, c2row5, c2row6);

   //not not7(aNEb, aEQb);

   //or or3(aGEb, aEQb, aGTb), or4(aLEb, aEQb, aLTb);

endmodule







