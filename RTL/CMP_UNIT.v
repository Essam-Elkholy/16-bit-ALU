module CMP_UNIT #(parameter DATA_WIDTH = 16) (
    input wire [DATA_WIDTH-1:0] A,
    input wire [DATA_WIDTH-1:0] B,
    input wire [1:0]       ALU_FUN,
    input wire             CLK,
    input wire             RST,
    input wire             CMP_Enable,
    
    output reg [DATA_WIDTH-1:0] CMP_OUT,
    output reg             CMP_Flag
);

    // Internal signals
    reg [DATA_WIDTH-1:0] OUT_comb;
    reg             Flag_comb;

    // Combinational Logic for comparison operations
    always @(*) begin
        OUT_comb  = {DATA_WIDTH{1'b0}};
        Flag_comb = 1'b0;
        
        if (CMP_Enable) begin
            Flag_comb = 1'b1;
            case(ALU_FUN)
                2'b00: begin OUT_comb = {DATA_WIDTH{1'b0}}; Flag_comb = 1'b0; end // NOP
                2'b01: OUT_comb = (A == B) ? {{(DATA_WIDTH-2){1'b0}}, 2'b01} : {DATA_WIDTH{1'b0}};
                2'b10: OUT_comb = (A > B)  ? {{(DATA_WIDTH-2){1'b0}}, 2'b10} : {DATA_WIDTH{1'b0}};
                2'b11: OUT_comb = (A < B)  ? {{(DATA_WIDTH-2){1'b0}}, 2'b11} : {DATA_WIDTH{1'b0}};
            endcase
        end
    end

    // Sequential Logic for output and flag
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            CMP_OUT  <= {DATA_WIDTH{1'b0}};
            CMP_Flag <= 1'b0;
        end else begin
            CMP_OUT  <= OUT_comb;
            CMP_Flag <= Flag_comb;
        end
    end
endmodule