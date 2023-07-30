////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_channel2.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module simulates the full transmit and recieve circuit
// with a clock cycle that makes it so that the parity checker misses so values
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
module tb_channel2();
   reg        clk_enable;	// Locally-created clock enable signal
   reg        tran_enable;	// Locally-created counter enable signal
   reg        tran_clr;		// Locally-created counter clear signal
   wire       clk_out;		// Clock produced by the clk module
   //wire [3:0] count1, count2;	// Counter outputs for the two 4-bit counters
   wire [9:0] tran_out;	// Counter outputs for the two 4-bit counters
   wire [9:0] data_out;	// Counter outputs for the two 4-bit counters
 wire data_valid;	// Counter outputs for the two 4-bit counters


   parameter PERIOD = 15;	// Delay from clear to valid output.

// Instantiate the clock generator with a period of 100 ns
   clk #PERIOD clk1(clk_enable, clk_out);

// Intantiate two versions of the counter. ctr1 uses the default values.
// ctr2 overrides the default values of the parameters with #(20,30) ns.
   transmit_bdeduffy          rec1(clk_out, tran_enable, tran_clr, tran_out);
   receive_bdeduffy           tra2(clk_out, tran_out, data_valid, data_out);

// Sequence the ENABLE and CLR signals
   initial begin
      clk_enable = 1;
      tran_enable = 0;
      tran_clr = 0;
      #10  tran_clr = 1;
      #40  tran_clr = 0;
      #50  tran_enable = 1;
      #400 tran_enable = 0;
      #200 tran_enable = 1;
      #300 tran_clr = 1;
      #60  tran_clr = 0;
   end

endmodule