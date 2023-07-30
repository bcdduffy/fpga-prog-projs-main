////////////////////////////////////////////////////////////////////////////////
// Filename:    hc280_bdeduffy.v
// Author:      Brenden Duffy
// Date:        03/23/22
// Version:     1
// Description: This module a device to take in 9 bits and check if the
// binary number has an even or odd amount of 1's
//
//
// Modification History:
// Date        By   Version  Change Description
// ============================================
// 03/25/2022  BDE  1        Original
////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/100ps

module hc280_bdeduffy(data_in, even, odd);
   input  [8:0] data_in;
   output       even, odd;
   wire  out;

   assign out = data_in[0] + data_in[1] + data_in[2] + data_in[3] + data_in[4] + data_in[5] + data_in[6] + data_in[7] + data_in[8]; 

   assign even = ~out;
   assign odd = out;

   specify
   (data_in *> even) = (20);
   (data_in *> odd) = (23);
   endspecify


endmodule