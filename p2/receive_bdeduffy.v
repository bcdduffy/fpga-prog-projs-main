////////////////////////////////////////////////////////////////////////////////
// Filename:    receive_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module is the receive module of the channel which takes
// data in into a 10 bit register to check if the parity still exists within the
// data, then to output if the data is valid or not
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////

module receive_bdeduffy(clk, data_in, data_valid, data_out);
   input        clk;
   input  [9:0] data_in;
   output       data_valid;
   output [9:0] data_out;
   wire out, even;

   register10bit_bdeduffy U4(clk, data_in, data_out);

   hc280_bdeduffy                U5(data_out[8:0], even, odd);

   assign data_valid = ~(odd ^ data_out[9]);
   


endmodule
