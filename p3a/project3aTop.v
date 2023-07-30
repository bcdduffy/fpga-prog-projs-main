////////////////////////////////////////////////////////////////////////////////
// Filename: project3aTop.v
// Author:      Brenden Duffy
// Date:        04 April 2022
// Revision: 1
//
// This is the top-level module for ECE 3544 Project 3a.
// Do not modify the module declaration or ports in this file.
// When synthesizing to the DE1-SoC, this file should be used with the provided
// Quartus project so that the FPGA pin assignments are made correctly.
//
// YOU MUST MAKE THE PIN ASSIGNMENTS FOR THE INPUTS AND OUTPUTS OF THIS MODULE.
// FOLLOW THE INSTRUCTIONS IN THE DOCUMENT ON PIN PLACEMENT.
// CONSULT THE MANUAL FOR INFORMATION ON THE PIN LOCATIONS.

module project3aTop(SW, LED, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
   input  [9:0] SW;
   output [9:0] LED;
   output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire xor3, xor2, xor1;
	
	wire even1, even2, even3, even4, even5, even6;
	
	wire oddT1, oddT2, oddT3, oddR1, oddR2, oddR3;
	
	wire [8:0] T1in, T2in, T3in, R1in, R2in, R3in;
	
	wire [6:0] corrupterOut;
	
	wire [8:0] corrupterBus;
	 
// This should allow you to see the values of the switches on the LEDs.
// YOU WILL NEED TO CHANGE THIS TO SATISFY THE SPECIFICATION REQUIREMENTS
   assign LED[6:0] = SW[6:0];

// This maps certain switches to the seven-segment display inputs.
// Use this as an example of instantiating in the top-level module, and as a
// test of your seven-segment displays. 
// You may leave these instantiations in place in your final submission, since
// Project 3A does not use the seven-segment displays.

   project3aTest U0(SW[1:0], HEX0);
	project3aTest U1(SW[3:2], HEX1);
	project3aTest U2(SW[5:4], HEX2);
	project3aTest U3(SW[7:6], HEX3);
	project3aTest U4(SW[9:8], HEX4);
   project3aTest U5(SW[9:8], HEX5);	 

// Your top-level module should conform to block diagram provided in the
// specification. It should contain:
// - Six instantiations of your 74HC280.
//   - Three represent "transmit-side" parity checkers. Use the appropriate
//     bits of SW[6:0] as the inputs to these parity checkers. YOU WILL NOT
//     USE ALL OF THE BIT OF SW[6:0] as the inputs to these parity checkers.
//   - Three represent "receive-side" parity checkers. Use the appropriate
//     outputs of the bit corrupter module as the inputs to these parity
//     checkers. YOU WILL NOT USE ALL OF THE BIT CORRUPTER outputs as the
//     inputs to these parity checkers.
// - One instantiation of your Bit Corrupter module. Use SW[6:0] as the 7-bit
//   input word. Use SW[9:7] as the index input. Use the appropriate outputs
//   of the bit corrupter module as the inputs to the "receive-side" parity
//   checkers. 
// - Three 2-input XOR gates. Connect corresponding pairs of "transmit-side" and
//   "receive-side" parity checker outputs as the inputs of your XOR gates.


hc280_bdeduffy                H1(T1in, even1, oddT1);
hc280_bdeduffy                H2(T2in, even2, oddT2);
hc280_bdeduffy                H3(T3in, even3, oddT3);

bit_corrupter                H4(SW[9:7], SW[6:0], corrupterOut);

hc280_bdeduffy                H5(R1in, even4, oddR1);
hc280_bdeduffy                H6(R2in, even5, oddR2);
hc280_bdeduffy                H7(R3in, even6, oddR3);

assign corrupterBus = {2'b00, corrupterOut};

assign LED[9] = oddT3^oddR3;
assign LED[8] = oddT2^oddR2;
//assign LED[8] = 1'b1;
assign LED[7] = oddT1^oddR1;


//assign T1in, T2in, T3in, R1in, R2in, R3in;

assign T1in = { 2'b00, SW[6], 1'b0, SW[4], 1'b0, SW[2], 1'b0, SW[0]};
assign T2in = { 2'b00, SW[6:5], 2'b00, SW[2:1], 1'b0};
assign T3in = { 2'b00, SW[6:3], 3'b000};

assign R1in = { 2'b00, corrupterBus[6], 1'b0, corrupterBus[4], 1'b0, corrupterBus[2], 1'b0, corrupterBus[0]};
assign R2in = { 2'b00, corrupterBus[6:5], 2'b00, corrupterBus[2:1], 1'b0};
assign R3in = { 2'b00, corrupterBus[6:3], 3'b000};

endmodule
