////////////////////////////////////////////////////////////////////////////////
// Filename:    bit_corrupter_bdeduffy.v
// Author:      Brenden Duffy
// Date:        04 April 2022
// Version:     1
// Description: Module that takes in a 7 bit word with 3 select lines
// to select which bit in the word is corrupted, outputs corrupt word.

module bit_corrupter(index, input_word, output_word);
	input  [2:0] index;
	input  [7:1] input_word;
	output [7:1] output_word; 
	reg [7:1] output_word; 

	always@(index, input_word) begin
		case (index)
			3'd1:    output_word = {input_word[7:2], ~input_word[1]};
			3'd2:    output_word = {input_word[7:3], ~input_word[2], input_word[1]};
			3'd3:    output_word = {input_word[7:4], ~input_word[3], input_word[2:1]};
			3'd4:    output_word = {input_word[7:5], ~input_word[4], input_word[3:1]};
			3'd5:    output_word = {input_word[7:6], ~input_word[5], input_word[4:1]};
			3'd6:    output_word = {input_word[7], ~input_word[6], input_word[5:1]};
			3'd7:    output_word = {~input_word[7], input_word[6:1]};
	      default: output_word = input_word;
			endcase
			end
	
	
	endmodule