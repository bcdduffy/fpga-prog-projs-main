////////////////////////////////////////////////////////////////////////////////
// Filename:    counter9bit_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module is a 9bit counter which on clock cycles advances the clock
// and asynchronously clears the clock on the clear signal positive edge
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module counter9bit_bdeduffy (enable, clear, clk, count);
   input        enable;		// Active-high counter enable.
   input        clear;		// Asynchronous active-high clear
   input        clk;		// System clock
   output [8:0] count;		// 4-bit counter output
   reg    [8:0] count;		// Variable count is defined procedurally.

   parameter CLRDEL = 10;	// Delay from clear to valid output.
   parameter CLKDEL = 15;	// Delay from clock to valid output.

// Build behavioral 4-bit up-counter with asynchronous clear
   always @(posedge clk or posedge clear) begin //h
      if(clear)
         count <= #CLRDEL 4'b0;
      else begin
         if(enable) begin
            if(count == 9'd511)
               count <= #CLKDEL 9'b000000000;
            else
               count <= #CLKDEL count + 9'd1;
         end
      end
   end

endmodule
