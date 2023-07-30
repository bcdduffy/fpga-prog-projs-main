////////////////////////////////////////////////////////////////////////////////
// Filename:    transmit_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module is the transmit module of the channel is driven
// by the clock to input the clock number into a register while adding a parity bit
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

module transmit_bdeduffy(clk, enable, clear, data_out);
   input        clk, enable, clear;
   output [9:0] data_out;
   wire [8:0] ctr_out;
   wire even, odd;
   wire [9:0] reg_in;



   counter9bit_bdeduffy          U1(enable, clear, clk, ctr_out);
   hc280_bdeduffy                U2(ctr_out, even, odd);

   assign reg_in = {odd, ctr_out};
   register10bit_bdeduffy U3(clk, reg_in, data_out);
   


endmodule
