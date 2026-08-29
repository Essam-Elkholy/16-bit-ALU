module ARITHMETIC_UNIT #(parameter DATA_WIDTH = 16) (
    input wire signed [DATA_WIDTH-1:0] A, B, // DATA_WIDTH-bit input operands
    input wire [1:0]                   ALU_FUN, // 4-bit ALU function select
    input wire                         CLK, // Clock signal
    input wire                         RST,
    input wire                         Arith_Enable, // Arithmetic enable signal
	
    output reg signed [DATA_WIDTH-1:0] Arith_OUT, // Output result
    output reg                         Arith_Flag // Arithmetic flag output
);
   
    // Internal signals
    reg signed [DATA_WIDTH-1:0] OUT_Comb;
    reg                  Flag_Comb;

    // Combinational Logic for arithmetic operations
	always @(*) begin
	    OUT_Comb = {DATA_WIDTH{1'b0}};  // OUT_Comb = 16'b 0000 0000 0000 0000
		Flag_Comb = 1'b0;
		
		if (Arith_Enable) begin
		    Flag_Comb = 1'b1;
			case(ALU_FUN)
			2'b00: OUT_Comb = A + B;
            2'b01: OUT_Comb = A - B;
            2'b10: OUT_Comb = A * B;
            2'b11: OUT_Comb = A / B;
            endcase
        end
    end

    // Sequential Logic for output and flag
	always @(posedge CLK or negedge RST) begin
	    if (!RST) begin  // RST is active LOW
	        Arith_OUT <= {DATA_WIDTH{1'b0}};  // OUT_Comb = 16'b 0000 0000 0000 0000
		    Arith_Flag <= 1'b0;
		end else begin
		    Arith_OUT <= OUT_Comb;
			Arith_Flag <= Flag_Comb;
		end
	end
	
endmodule
