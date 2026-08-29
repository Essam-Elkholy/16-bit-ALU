module LOGIC_UNIT #(parameter DATA_WIDTH = 16) (
    input wire [DATA_WIDTH-1:0] A, B, // DATA_WIDTH-bit input operands
    input wire [1:0]            ALU_FUN, // 4-bit ALU function select
    input wire                  CLK, // Clock signal
    input wire                  RST,
    input wire                  Logic_Enable, // Logic enable signal
	
    output reg [DATA_WIDTH-1:0] Logic_OUT, // Output result
    output reg                  Logic_Flag // Logic flag output
);
   
    // Internal signals
    reg [DATA_WIDTH-1:0] OUT_Comb;
    reg                  Flag_Comb;
	
	// Combinational Logic for logic operations
    always @(*) begin
        OUT_Comb = {DATA_WIDTH{1'b0}};
		Flag_Comb = 1'b0;
		
		if (Logic_Enable) begin
		    Flag_Comb = 1'b1;
			case(ALU_FUN)
			    2'b00: OUT_Comb = A & B;   // AND
				2'b01: OUT_Comb = A | B;   // OR
                2'b10: OUT_Comb = ~(A & B);// NAND
                2'b11: OUT_Comb = ~(A | B);// NOR
			endcase
		end
	end
	
    // Sequential Logic for output and flag
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin  // RST is active LOW
            Logic_OUT <= {DATA_WIDTH{1'b0}};
            Logic_Flag <= 1'b0;
        end else begin
            Logic_OUT <= OUT_Comb;
            Logic_Flag <= Flag_Comb;
        end
    end

endmodule