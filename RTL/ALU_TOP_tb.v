`timescale 1ns / 1ns
module ALU_TOP_tb;

    // Parameters
    parameter DATA_WIDTH = 16;

    // Inputs
    reg signed [DATA_WIDTH-1:0] A_tb;
    reg signed [DATA_WIDTH-1:0] B_tb;
    reg [3:0] ALU_FUN;
    reg CLK;
    reg RST;

    // Outputs
    wire signed [DATA_WIDTH-1:0] Arith_OUT_tb;
    wire Arith_Flag;
    wire [DATA_WIDTH-1:0] Logic_OUT_tb;
    wire Logic_Flag;
    wire [DATA_WIDTH-1:0] CMP_OUT_tb;
    wire CMP_Flag;
    wire [DATA_WIDTH-1:0] SHIFT_OUT_tb;
    wire SHIFT_Flag;

    // Instantiate the ALU_TOP module
    ALU_TOP #(.DATA_WIDTH(DATA_WIDTH)) uut (
        .A(A_tb),
        .B(B_tb),
        .ALU_FUN(ALU_FUN),
        .CLK(CLK),
        .RST(RST),
        .Arith_OUT(Arith_OUT_tb),
        .Arith_Flag(Arith_Flag),
        .Logic_OUT(Logic_OUT_tb),
        .Logic_Flag(Logic_Flag),
        .CMP_OUT(CMP_OUT_tb),
        .CMP_Flag(CMP_Flag),
        .SHIFT_OUT(SHIFT_OUT_tb),
        .SHIFT_Flag(SHIFT_Flag)
    );

    initial begin
        CLK = 1'b0;
        forever begin
          #4000 CLK = 1'b1; // Toggle clock every 4 ns
          #6000 CLK = 1'b0; // Toggle clock every 6 ns
        end
    end

    // Reausable task to apply stimuli to the ALU
    task apply_test;
        input [3:0] alu_fun;
        input signed [DATA_WIDTH-1:0] a_val;
        input signed [DATA_WIDTH-1:0] b_val;
        input [127:0] test_name; // 128-bit string for test name
        begin
            A_tb = a_val;
            B_tb = b_val;
            ALU_FUN = alu_fun;
            #10000; // Wait for 10 ns to allow the operation to complete
            $display("Test: %s | A: %d, B: %d | ALU_FUN: %b | Arith_OUT: %d, Logic_OUT: %d, CMP_OUT: %d, SHIFT_OUT: %d",
                     test_name, A_tb, B_tb, ALU_FUN, Arith_OUT_tb, Logic_OUT_tb, CMP_OUT_tb, SHIFT_OUT_tb);
        end
    endtask

    // Main Test Execution
    initial begin
        // 1. Apply active-low reset
        A_tb = 0; B_tb = 0; ALU_FUN = 4'b1000;
        RST = 1'b0; 
        #10000; 
        RST = 1'b1; 

        $display("--- STARTING 28-CASE ALU SIMULATION ---");

        // --- 1. SIGNED ARITHMETIC ADDITION ---
        apply_test(4'b0000, -4, -10, "ADD Neg+Neg");
        apply_test(4'b0000, 15, -5,  "ADD Pos+Neg");
        apply_test(4'b0000, -20, 30, "ADD Neg+Pos");
        apply_test(4'b0000, 50, 25,  "ADD Pos+Pos");

        // --- 2. SIGNED ARITHMETIC SUBTRACTION ---
        apply_test(4'b0001, -15, -10, "SUB Neg-Neg");
        apply_test(4'b0001, 20, -5,   "SUB Pos-Neg");
        apply_test(4'b0001, -10, 10,  "SUB Neg-Pos");
        apply_test(4'b0001, 30, 15,   "SUB Pos-Pos");

        // --- 3. SIGNED ARITHMETIC MULTIPLICATION ---
        apply_test(4'b0010, -3, -4, "MUL Neg*Neg");
        apply_test(4'b0010, 5, -6,  "MUL Pos*Neg");
        apply_test(4'b0010, -7, 2,  "MUL Neg*Pos");
        apply_test(4'b0010, 8, 8,   "MUL Pos*Pos");

        // --- 4. SIGNED ARITHMETIC DIVISION ---
        apply_test(4'b0011, -20, -5, "DIV Neg/Neg");
        apply_test(4'b0011, 30, -6,  "DIV Pos/Neg");
        apply_test(4'b0011, -40, 8,  "DIV Neg/Pos");
        apply_test(4'b0011, 50, 10,  "DIV Pos/Pos");

        // --- 5. LOGICAL OPERATIONS ---
        apply_test(4'b0100, 16'hFF00, 16'h0F0F, "LOGIC AND  ");
        apply_test(4'b0101, 16'hFF00, 16'h0F0F, "LOGIC OR   ");
        apply_test(4'b0110, 16'hFF00, 16'h0F0F, "LOGIC NAND ");
        apply_test(4'b0111, 16'hFF00, 16'h0F0F, "LOGIC NOR  ");

        // --- 6. COMPARE OPERATIONS ---
        apply_test(4'b1001, 25, 25, "CMP Equal  ");
        apply_test(4'b1010, 50, 10, "CMP Greater");
        apply_test(4'b1011, 5, 80,  "CMP Less   ");

        // --- 7. SHIFT OPERATIONS ---
        apply_test(4'b1100, 16'h0004, 16'h0000, "SHIFT A >> ");
        apply_test(4'b1101, 16'h0004, 16'h0000, "SHIFT A << ");
        apply_test(4'b1110, 16'h0000, 16'h0008, "SHIFT B >> ");
        apply_test(4'b1111, 16'h0000, 16'h0008, "SHIFT B << ");
        
        // --- 8. NOP ---
        apply_test(4'b1000, 16'hFFFF, 16'hFFFF, "NOP        ");

        $display("--- SIMULATION COMPLETE ---");
        $stop;
    end

endmodule