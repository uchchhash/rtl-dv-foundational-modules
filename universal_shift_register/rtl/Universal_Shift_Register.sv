// 4-bit universal shift register
module Universal_Shift_Register( 
	output reg [3:0]	A_par, 			// Register output
	input [3:0] 		I_par, 			// Parallel input
	input 				s1, s0, 		// Select inputs
	input 				MSB_in, LSB_in,	// Serial inputs
	input 				clk, 			// Clock 
	input 				reset 			// Reset signal
);
	always @ (posedge clk, negedge reset) begin
		if (reset == 0) A_par <= 4'b0000;
		else begin
			case ({s1, s0})
				2'b00: A_par <= A_par; 					// No change
				2'b01: A_par <= {MSB_in, A_par[3: 1]}; 	// Shift right
				2'b10: A_par <= {A_par[2: 0], LSB_in}; 	// Shift left
				2'b11: A_par <= I_par; 					// Parallel load of input
			endcase
		end
	end

endmodule


/*
// ----------------- SPECIFICATION ----------------- //

* This is an Universal_Shift_Register Circuit have following functions:
	1. Load data into register
	2. Left Shift operation
	3. Right Shift Operation

// Signal Descriptions
-----------------------

* A_par is an output data signal of 4 bits width
* I_par is an input data signal of 4 bits width

* s1 and s0 are control signals

* LSB_in is a data input for shifting in least significant bit into the circuit
* MSB_in is a data input for shifting in most significant bit into the circuit


// Circuit Functionality
-------------------------

* Active Low reset signal which resets circuit when reset = 0

* Conditions for s1 and s0:

	1. 00 : Do Nothing / No Change
	2. 01 : Do shift right operation
	3. 01 : Do shift left operation
	4. 11 : Load I_par data into the circuit
	
*/
