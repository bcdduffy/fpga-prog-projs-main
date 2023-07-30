////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    tb_fsm16bit.v
// Author:      Jason Thweatt
// Date:        28 March 2017
// Version:     2
// Description: FSM testbench.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns

module tb_fsm16bit();
	reg         clock, reset, enable, check, mode, direction;
	reg			clock_en;
	reg   [3:0] value;
	wire [15:0] count;

	 parameter PERIOD = 20;	// Delay from clear to valid output.

 initial clock = 0;
	
	// Instantiate counter.
	fsm16bit dut(clock, reset, enable, check, mode, direction, value, count);	

	// Test the counter functionality here.
	// You should set up a 50 MHz clock, along with the various control and input signals.
	// Avoid using the Project 2 clock module, since it is not synthesizable.
	// Adding it to this project will cause Quartus to complain about its synthesizability.
	
	
	// Sequence the ENABLE and CLR signals
   initial begin
      clock_en = 1;
		reset = 1;
		check = 1;
		mode = 0;
enable = 0;
		direction = 0;
		value = 4'b0000;
		
		//reset
		#50 reset = 0;
		#50 reset = 1;
		
		
//Test Adding and Subtraction
      #50  value = 4'b0001;
	mode = 1;
	direction = 1;
	#20  enable = 1;
	#20 enable = 0;

	#20  enable = 1;
	#20 enable = 0;

	#20  enable = 1;
	#20 enable = 0;

	#20  enable = 1;
	#20 enable = 0;
	//Test Adds to four

	#50  value = 4'b0011;
	#20  enable = 1;
	#20 enable = 0;
	//Test Adds to seven
	direction = 0;
	#20  enable = 1;
	#20 enable = 0;

	#20  enable = 1;
	#20 enable = 0;

	//Test subtracts to 1	

	mode = 0;  //Test shift
	direction = 1;
	#20  enable = 1;
	#20 enable = 0;
	#20  enable = 1;
	#20 enable = 0;
//Test shifts left twice	
direction = 0;
	#20  enable = 1;
	#20 enable = 0;

	#20  enable = 1;
	#20 enable = 0;

	#20  enable = 1;
	#20 enable = 0;
//Test shifts right thrice to 1 at top
	direction = 1;
	#20  enable = 1;
	#20 enable = 0;

	#20 check = 0;
	#20  enable = 1;
	#20 enable = 0;
//Test 3872


   end
	
	
	
	   always begin
      #(PERIOD/2) if(clock_en)
         clock = ~clock;
   end

endmodule
