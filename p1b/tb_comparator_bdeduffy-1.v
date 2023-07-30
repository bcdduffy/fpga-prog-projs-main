////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_comparator_bdeduffy.v
// Author:      Brenden Duffy
// Date:        25 Feb 2022
// Version:     1
// Description: This file contains a test bench for the comparator for Project2A
////////////////////////////////////////////////////////////////////////////////////////////////////

// Time Unit = 1 ns (#1 = 1 ns)
// Simulation Precision = 1 ns
`timescale 1ns/1ns 

// Testbenches don't have arguments. Instead, the values that we want to modify are regs.
// ANY VALUE THAT IS THE TARGET OF A PROCEDURE MUST BE A REG.
// The values that we wish to observe are wires.

module comparator_bench();
   reg  [2:0] decA_in;		// A vector representing the three inputs A digits
   reg  [2:0] decB_in;		// A vector representing the three inputs B digits
   wire aGTb, aGEb, aLTb, aLEb, aEQb, aNEb; //Wires to observe the six output comparator conditions

   reg   [3:0] count;
   reg   [3:0] count2;

// Instantiate the comparator (the identifier is dut, or "device under test").

   comparator_continuous_bdeduffy dut1(decA_in, decB_in, aGTb, aGEb, aLTb, aLEb, aEQb, aNEb);

// The input test stimulus is defined as a pair of initial blocks.
// Each initial block is a procedure.
// Even though the statements in each initial block execute in sequence, THE TWO INITIAL BLOCKS EXECUTE CONCURRENTLY.
// Each one begins at simulation time t = 0 and continues according to the timing delays that each one contains.

// Both initial blocks should cover the same 600 ns of simulation time.

   initial begin
      decA_in = 3'b000;	// (t = 0) Apply the first input combination.
      decB_in = 3'b000;	// (t = 0) Apply the first input combination.
      #150;		// Wait for 100 ns.


	//Nested For loop first loops throuhg all values of A then in combination with all possible values of B
      for(count = 0; count < 8; count = count + 1) begin
         decA_in = count[2:0];
         #50;
		for(count2 = 0; count2 < 8; count2 = count2 + 1) begin
         	decB_in = count2[2:0];
         	#50;
      		end
      end

      #150;			// Wait for 150 ns after each input change.
   end

endmodule