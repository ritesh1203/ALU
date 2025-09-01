`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2025 18:48:00
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_tb;

  reg [7:0] A, B;
  reg [3:0] SL;
  wire [7:0] Out;
  wire C, Z, P, S;

  // Instantiate ALU
  alu ALU (.A(A), .B(B), .SL(SL), .Out(Out), .C(C), .Z(Z), .S(S), .P(P));

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);
    $monitor("T=%0t | A=%h, B=%h, SL=%h | Out=%h, C=%b, Z=%b, S=%b, P=%b", $time, A, B, SL, Out, C, Z, S, P);

    // fixed test inputs
    A = 8'hf8;  // 1001_0011
    B = 8'h67;  // 0000_0010

    // step through all ALU operations
        SL = 4'b0000;
    #10 SL = 4'b0001;
    #10 SL = 4'b0010;
    #10 SL = 4'b0011;
    #10 SL = 4'b0100;
    #10 SL = 4'b0101;
    #10 SL = 4'b0110;
    #10 SL = 4'b0111;
    #10 SL = 4'b1000;
    #10 SL = 4'b1001;
    #10 SL = 4'b1010;
    #10 SL = 4'b1011;
    #10 SL = 4'b1100;
    #10 SL = 4'b1101;
    #10 SL = 4'b1110;
    #10 SL = 4'b1111;
    #10 $finish;
  end
endmodule
