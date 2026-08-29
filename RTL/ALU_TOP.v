module ALU_TOP #(parameter DATA_WIDTH = 16) (
    input  wire [DATA_WIDTH-1:0] A,
    input  wire [DATA_WIDTH-1:0] B,
    input  wire [3:0]       ALU_FUN,
    input  wire             CLK,
    input  wire             RST,

    output wire [DATA_WIDTH-1:0] Arith_OUT,
    output wire             Arith_Flag,
    output wire [DATA_WIDTH-1:0] Logic_OUT,
    output wire             Logic_Flag,
    output wire [DATA_WIDTH-1:0] CMP_OUT,
    output wire             CMP_Flag,
    output wire [DATA_WIDTH-1:0] SHIFT_OUT,
    output wire             SHIFT_Flag
);

    // Internal Enable Wires
    wire Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable;

    // 1. Instantiate Decoder
    Decoder dec_inst (
        .ALU_FUN_TOP(ALU_FUN[3:2]),
        .Arith_Enable(Arith_Enable),
        .Logic_Enable(Logic_Enable),
        .CMP_Enable(CMP_Enable),
        .Shift_Enable(Shift_Enable)
    );

    // 2. Instantiate Arithmetic Unit
    ARITHMETIC_UNIT #(.DATA_WIDTH(DATA_WIDTH)) arith_inst (
        .A(A), .B(B), .ALU_FUN(ALU_FUN[1:0]), .CLK(CLK), .RST(RST),
        .Arith_Enable(Arith_Enable), .Arith_OUT(Arith_OUT), .Arith_Flag(Arith_Flag)
    );

    // 3. Instantiate Logic Unit
    LOGIC_UNIT #(.DATA_WIDTH(DATA_WIDTH)) logic_inst (
        .A(A), .B(B), .ALU_FUN(ALU_FUN[1:0]), .CLK(CLK), .RST(RST),
        .Logic_Enable(Logic_Enable), .Logic_OUT(Logic_OUT), .Logic_Flag(Logic_Flag)
    );

    // 4. Instantiate Compare Unit
    CMP_UNIT #(.DATA_WIDTH(DATA_WIDTH)) cmp_inst (
        .A(A), .B(B), .ALU_FUN(ALU_FUN[1:0]), .CLK(CLK), .RST(RST),
        .CMP_Enable(CMP_Enable), .CMP_OUT(CMP_OUT), .CMP_Flag(CMP_Flag)
    );

    // 5. Instantiate Shift Unit
    SHIFT_UNIT #(.DATA_WIDTH(DATA_WIDTH)) shift_inst (
        .A(A), .B(B), .ALU_FUN(ALU_FUN[1:0]), .CLK(CLK), .RST(RST),
        .Shift_Enable(Shift_Enable), .SHIFT_OUT(SHIFT_OUT), .SHIFT_Flag(SHIFT_Flag)
    );

endmodule