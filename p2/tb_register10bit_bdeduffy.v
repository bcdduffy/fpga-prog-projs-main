////////////////////////////////////////////////////////////////////////////////
// Filename:    receive_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module is the reviece module of the channel which takes
// data in into a 10 bit register to check if the parity still exists within the
// data, then to output if the data is valid or not
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
module tb_register10bit_bdeduffy();
   reg        clk_enable;	
   reg  [9:0] reg_ins;
   wire  [9:0]     reg_outs;
   reg  [10:0] count;
   wire       clk_out;

   //input  [3:0] hex_digit;
   //output [6:0] hex_display;

   parameter PERIOD = 200;	// Delay from clear to valid output.

   clk #(100) clk1(clk_enable, clk_out);


   register10bit_bdeduffy dut(clk_out, reg_ins, reg_outs);


 
   initial begin
     clk_enable = 1;
      reg_ins = 10'b0000000000;
      for(count = 0; count < 1024; count = count + 1) begin
         reg_ins = count[9:0];
         #200;
      end
   end

endmodule
