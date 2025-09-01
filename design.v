`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2025 18:44:30
// Design Name: 8-bit ALU
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 8-bit ALU with multiple operations, flags (Carry, Zero, Sign, Parity)
// 
// Dependencies: None
// 
// Revision:
// Revision 0.02 - Fixed subtraction, parity, XNOR, shift, and flags
// Additional Comments: Safe for synthesis
// 
//////////////////////////////////////////////////////////////////////////////////

module alu (A, B, SL, Out, C, Z, S, P);

	input  [7:0] A, B;                  
    input  [3:0] SL;
    output [7:0] Out;
    output       C, Z, S, P;


    reg  [8:0] Result;     // 9 bits for carry
    reg        Sholder;    // Sign flag
    reg        Zholder;    // Zero flag
    reg        Pholder;    // Parity flag

    wire [3:0] Ptmp;       // Temp for parity calculation

    assign Ptmp = Result[0] + Result[1] + Result[2] + Result[3] + Result[4] + Result[5] + Result[6] + Result[7];   

    assign S   = Sholder;
    assign P   = Pholder;
    assign Out = Result[7:0];
    assign C   = Result[8];
    assign Z   = Zholder;
    
    always @(*) begin
        // default values (avoid latches)
        Result   = 9'b0;
        Sholder  = 1'b0;
        Zholder  = 1'b0;
        Pholder  = 1'b0;

        case (SL)
            4'b0000: Result = 9'b000000000;      // Clear
            4'b0001: Result = {1'b0, B};         // Pass B
            4'b0010: Result = {1'b0, ~B};        // NOT B
            4'b0011: Result = {1'b0, A};         // Pass A
            4'b0100: Result = {1'b0, ~A};        // NOT A
            4'b0101: Result = {1'b0, A} + 1;     // Increment A
            4'b0110: Result = {1'b0, A} - 1;     // Decrement A
            4'b0111: Result = {1'b0, (A << B[2:0])}; // Shift left A by 0-7

            4'b1000: begin // A + B
                Result   = {1'b0, A} + {1'b0, B};
            end

            4'b1001: begin // A - B
                Result   = {1'b0, A} - {1'b0, B};
            end

            4'b1010: begin // A + B + Cin (here Cin = C from last operation)
                Result   = {1'b0, A} + {1'b0, B} + {8'b0, C};
            end

            4'b1011: begin // A - B - Cin
                Result   = {1'b0, A} - {1'b0, B} - {8'b0, C};
            end

            4'b1100: Result = {1'b0, (A & B)};   // AND
            4'b1101: Result = {1'b0, (A | B)};   // OR
            4'b1110: Result = {1'b0, (A ^ B)};   // XOR
            4'b1111: Result = {1'b0, ~(A ^ B)};  // XNOR

            default: Result = 9'b0;
        endcase

        // ---- Update Flags ----
        Sholder = Result[7];                      // Sign flag
        Zholder = (Result[7:0] == 8'b0);          // Zero flag
        Pholder = (Ptmp % 2 == 0);                // Even parity = 1
    end
endmodule






