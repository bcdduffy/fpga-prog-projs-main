////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_hc280_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module is the test bench for the HC280 parity module
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module tb_hc280_bdeduffy();
   reg        clk_enable;	// Locally-created clock enable signal
   reg        ctr_enable;	// Locally-created counter enable signal
   reg        ctr_clr;		// Locally-created counter clear signal
   wire       clk_out;		// Clock produced by the clk module
   //wire [8:0] count1, count2;	// Counter outputs for the two 4-bit counters
 wire [8:0] count1;	// Counter outputs for the two 4-bit counters
   wire even, odd;

// Instantiate the clock generator with a period of 100 ns
   clk #(100) clk1(clk_enable, clk_out);

// Intantiate two versions of the counter. ctr1 uses the default values.
// ctr2 overrides the default values of the parameters with #(20,30) ns.
   counter9bit_bdeduffy          ctr1(ctr_enable, ctr_clr, clk_out, count1);
   //counter9bit_bdeduffy #(20,30) ctr2(ctr_enable, ctr_clr, clk_out, count2);

   hc280_bdeduffy          ctr3(count1, even, odd);

// Sequence the ENABLE and CLR signals
   initial begin
      clk_enable = 1;
      ctr_enable = 0;
      ctr_clr = 0;
      #10  ctr_clr = 1;
      #40  ctr_clr = 0;
      #50  ctr_enable = 1;
      #400 ctr_enable = 0;
      #200 ctr_enable = 1;
      #300 ctr_clr = 1;
      #60  ctr_clr = 0;
   end

endmodule
