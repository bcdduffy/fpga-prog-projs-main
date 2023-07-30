////////////////////////////////////////////////////////////////////////////////
// Filename:    register10bit_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module is a 10 bit register, which loads in a 10 bit
// input into the circuit at teh positive clock edge
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

module register10bit_bdeduffy(clk, d_in, q_out); 
   input        clk;
   input  [9:0] d_in; 
   output [9:0] q_out; 
   reg    [9:0] q_out;		// Variable count is defined procedurally.

   always @(posedge clk) begin //h
      q_out <= d_in;
   end

endmodule