////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    fsm16bit.v
// Author:      Brenden Duffy
// Date:        04 April 2024
// Version:     3 (04 April 2024)
// Description: A 16-bit synchronous FSM containing three functions,
// check, mode, and directiom. In check mode, the FSM loads the students last
// four digits into the state, in shift mode the state machine shifts its state
// number left or right based on the direction. Lastly the in arithmetic mode
// the FSM state is incremented or decremented based on the input value.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fsm16bit(clock, reset, enable, check, mode, direction, value, count);
	input         clock;
	input         reset;
	input         enable;
	input         check;
	input         mode;
	input         direction;
	input   [3:0] value;
	output [15:0] count;

	reg    [15:0] counter_state;
	

	parameter STUDENT_ID = 16'b0011011110000010;
	
// STATE MACHINE: This always block represents sequential logic, so it uses non-blocking assignments.
// It is sensitized to appropriate edges of the clock input and the clear input.
// You should picture this always block as a 16-bit register with an active-low asynchronous clear, plus the
// logic needed to derive the correct next state from the present state and the inputs.

	always @(posedge clock or negedge reset) begin

	// If a negative edge occured on reset, then reset must equal 0.
	// Since the effect of the reset occurs in the absence of a clock edge, this reset is ASYNCHRONOUS.
	// Release reset to permit synchronous behavior of the counter.

		if(reset == 1'b0)
			counter_state <= 16'b0;
	

	// If reset is not 0 but this always block is executing anyway, there must have been a positive clock edge.
	// On each positive clock edge where enable is asserted, update the counter state based on the counter state
	//	and the values of check, mode, direction, and value.
		
		else if(enable) begin
			if (check == 0) begin   				//First Sees if machine is in check mode
				counter_state <= STUDENT_ID;		//If in check mode, load value
			
			end
			else begin  					//If not in check mode
				if (mode == 0) begin		//The machine is in shift mode
												
					if (direction == 0) begin		//The machine is shifting right
						//counter_state <= counter_state >> 1;
						counter_state <= {counter_state[0], counter_state[15:1]};
					end
					else begin							//The machine is shifting left
						counter_state <= {counter_state[14:0], counter_state[15]};
						//counter_state <= counter_state << 1;
					end
					
				end			
				else begin   //The machine is in count mode
				
					if (direction == 0) begin		//The machine is decrementing
						counter_state <= counter_state - value;
					end
					else begin							//The machine is shifting left
						counter_state <= counter_state + value;
					end
				
				end
			
			end
			
			
		end
	end
	
// OUTPUT MACHINE: Since the output is always the same as the FSM state, assign the present state to the output.
// The output machine is combinational logic. A continuous assignment represents combinational logic.
// In a more complex FSM, the output machine would have consisted of an always block.
// Since the output machine represents combinational logic, this always block would have used blocking assignments.

// You should not need to modify this continuous assignment. 
// Changing counter_state in the state machine will change the output machine directly.

	assign count = counter_state; 

endmodule
