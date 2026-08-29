module SHIFT_UNIT #(parameter DATA_WIDTH = 16) (
    input  wire [DATA_WIDTH-1:0] A,
    input  wire [DATA_WIDTH-1:0] B,
    input  wire [1:0]       ALU_FUN,
    input  wire             CLK,
    input  wire             RST,
    input  wire             Shift_Enable,
    output reg  [DATA_WIDTH-1:0] SHIFT_OUT,
    output reg              SHIFT_Flag
);
    reg [DATA_WIDTH-1:0] OUT_comb;
    reg             Flag_comb;

    always @(*) begin
        OUT_comb  = {DATA_WIDTH{1'b0}};
        Flag_comb = 1'b0;
        
        if (Shift_Enable) begin
            Flag_comb = 1'b1;
            case(ALU_FUN)
                2'b00: OUT_comb = A >> 1;
                2'b01: OUT_comb = A << 1;
                2'b10: OUT_comb = B >> 1;
                2'b11: OUT_comb = B << 1;
            endcase
        end
    end

    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            SHIFT_OUT  <= {DATA_WIDTH{1'b0}};
            SHIFT_Flag <= 1'b0;
        end else begin
            SHIFT_OUT  <= OUT_comb;
            SHIFT_Flag <= Flag_comb;
        end
    end
endmodule