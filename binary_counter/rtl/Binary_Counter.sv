// Four-bit binary counter with parallel load
module Binary_Counter(
  output reg [3: 0] 	        A_count,	// Data output
  output reg				C_out,		// Output carry
  input [3:0] 		        Data_in,	// Data input
  input 				Enable,		// Activate the circuit
  input 				Count,		// Active high to count
  input 				Load,		// Active high to load
  input 				CLK,		// Positive-edge sensitive
  input 				reset		// Active low
);

  //   assign C_out = Count && (~Load) && (A_count >= 4'b1111);
  //   assign C_out = tmp;

  /*always @( posedge CLK) begin
    if (!Load) begin
    tmp <= &A_count && Count && reset;
    C_out <= tmp;
    end
  end*/
  
  always @ (posedge CLK, negedge reset) begin
    //if (~reset && CLK) begin
    //       A_count <= 4'b0000;
    //       C_out <= 1'b0;
    //end
    if (C_out) begin
    C_out <= 0;
    end
    if(reset) begin
      // this condition should use casez or casex
      if (Enable && Load) A_count <= Data_in;
      else if (Enable && !Load && Count) {C_out,A_count} <= A_count + 1'b1;
      else if (Enable && !Load && ~Count) A_count <= A_count - 1'b1;
      else A_count <= A_count; // redundant statement
    end
    else begin
      A_count <= 4'b0000;
      C_out <= 1'b0;
    end
  end

endmodule


/*
// ----------------- SPECIFICATION ----------------- //

* This is Four-bit binary counter Circuit have following functions:
	1. Load data into register
	2. Up-counting operation
	3. Down-counting operation

// Signal Descriptions
-----------------------

* A_count is an output data signal of 4 bits width
* C_out is an output data signal of 1 bits width, its an output carry

* Data_in is an input data signal of 4 bits width

* Enable, Load, Count are control signals

// Circuit Functionality
-------------------------

* Active Low reset signal which resets circuit when reset = 0

* Enable = 0, then the circuit keeps its current state
  Enable = 1, then load, up-counting and down-counting operations will work

* Load = 0, then the circuit keeps its current state
  Load = 1, then load Data_in data into the circuit

* Count = 0, down-counts the current data, -1
  Count = 1, up-counts the current data, +1

*/
