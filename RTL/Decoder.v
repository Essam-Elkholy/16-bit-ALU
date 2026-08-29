module Decoder (
    input wire [3:2] ALU_FUN_TOP, // 4-bit input
    output reg       Arith_Enable, // Arithmetic enable output
    output reg       Logic_Enable, // Logic enable output
    output reg       CMP_Enable, // Comparison enable output
    output reg       Shift_Enable // Shift enable output
);

    always @(*) begin
        Arith_Enable = 1'b0;
	    Logic_Enable = 1'b0;
	    CMP_Enable = 1'b0;
	    Shift_Enable = 1'b0;
        // Decoder logic based on ALU_FUN_TOP
	    case(ALU_FUN_TOP)
	        2'b00: Arith_Enable = 1'b1;
		    2'b01: Logic_Enable = 1'b1;
		    2'b10: CMP_Enable = 1'b1;
		    2'b11: Shift_Enable = 1'b1;
	    endcase
	end
	
endmodule