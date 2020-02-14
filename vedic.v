`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 01:40:56 PM
// Design Name: 
// Module Name: vedic
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

module ha(
  input wire a,b,
  output wire sum,carry
);
assign sum=a^b;
assign carry =a&b;
endmodule

module vedic_2x2(
     input wire [1:0] a,b,
     output wire [3:0] c//ket qua
    );
    wire [3:0] temp;
    //stage 1 :four multiplication opera of bit accourding to vedic logic done using and gates
    assign c[0] =a&b;
    assign temp[0]=a[1]&b[0];
    assign temp[1]=a[0]&b[1];
    assign temp[2]=a[1]&b[1];
    //stage 2 using two half adders
    ha z1(temp[0],temp[1],c[1],temp[3]);
    ha z2(temp[2],temp[3],c[2],c[3]);   
endmodule

module vedic_4x4(
  input wire [3:0] a,b,
  output wire [7:0] c
  );
  wire [3:0] q0,q1,q2,q3;
  wire [3:0] temp1;
  wire [5:0] temp2,temp3,temp4;
  wire [3:0] q4;
  wire [5:0] q5,q6;
  //using 4 2x2 vedic2x2
  vedic_2x2 z1(a[1:0],b[1:0],q0[3:0]);
  vedic_2x2 z2(a[3:2],b[1:0],q1[3:0]);
  vedic_2x2 z3(a[1:0],b[3:2],q2[3:0]);
  vedic_2x2 z4(a[3:2],b[3:2],q3[3:0]);
  //stage 1 adders
  assign temp1 ={2'b0,q0[3:2]};
  assign q4 =temp1+q1[3:0];
  assign temp2={2'b0,q2[3:0]};
  assign temp3 ={q3[3:0],2'b0};
  assign q5 =temp2+temp3;
  //stage 2 adders
  assign temp4 ={2'b0,q4[3:0]};
  assign q6 =temp4+q5;
  //output
  assign c[1:0]=q0[1:0];
  assign c[7:2]=q6[5:0];
  endmodule
  
  module vedic_8x8(
    input [7:0] a,b,
    output [15:0] c
    );
    wire [7:0] q0,q1,q2,q3;
    wire [7:0] temp1;
    wire [11:0] temp2,temp3,temp4;
    wire [7:0] q4;
    wire [11:0] q5,q6;
    //using 4 vedic_4x4
    vedic_4x4 z1(a[3:0],b[3:0],q0[7:0]);
    vedic_4x4 z2(a[7:4],b[3:0],q1[7:0]);
    vedic_4x4 z3(a[3:0],b[7:4],q2[7:0]);
    vedic_4x4 z4(a[7:4],b[7:4],q3[7:0]);
    //stage 1 adders
    assign temp1 ={3'b0,q0[7:4]};
    assign q4 =temp1 +q1[7:0];
    assign temp2 ={4'b0,q2[7:0]};
    assign temp3 ={q3[7:0],4'b0};
    assign q5 = temp2+temp3;
    //stage 2 adders
    assign temp4 ={4'b0,q4[7:0]};
    assign q6 =temp4 +q5;
    //output 
    assign c[3:0] =q0[3:0];
    assign c[15:4]=q6[11:0];
endmodule

module vedic_16x16(
       input wire [15:0] a,b,
       output wire [31:0] c
);
    wire [15:0] q0,q1,q2,q3;
    wire [15:0] temp1;
    wire [23:0] temp2,temp3,temp4;
    wire [15:0] q4;
    wire [23:0] q5,q6;
    //using 4 vedic_8x8
    vedic_8x8 z1(a[7:0],b[7:0],q0[15:0]);
    vedic_8x8 z2(a[15:8],b[7:0],q1[15:0]);
    vedic_8x8 z3(a[7:0],b[15:8],q2[15:0]);
    vedic_8x8 z4(a[15:8],b[15:8],q3[15:0]);
    //stage 1 adders
    assign temp1 ={8'b0,q0[15:8]};
    assign q4 =temp1+q1[15:0];
    assign temp2 ={8'b0,q2[15:0]};
    assign temp3 ={q3[15:0],8'b0};
    assign q5 =temp2+temp3;
    //stage 2 adders
    assign temp4 ={8'b0,q4[15:0]};
    assign q6 = temp4+q5;
    //output 
    assign c[7:0]= q0[7:0];
    assign c[31:8]=q6[23:0];
endmodule

module vedic_32x32(
     input wire [31:0] a,b,
     output wire [63:0] c
  );
  wire [31:0] q0,q1,q2,q3;
  wire [31:0] temp1;
  wire [47:0] temp2,temp3,temp4;
  wire [31:0] q4;
  wire [47:0] q5,q6;
  //using 4 vedic_16x16
  vedic_16x16 z1(a[15:0],b[15:0],q0[31:0]);
  vedic_16x16 z2(a[31:16],b[15:0],q1[31:0]);
  vedic_16x16 z3(a[15:0],b[31:16],q2[31:0]);
  vedic_16x16 z4(a[31:16],b[31:16],q3[31:0]);
  //stage 1 adders
  assign temp1 ={16'b0,q0[31:16]};
  assign q4 =temp1 +q1[31:0];
  assign temp2 ={16'b0,q2[31:0]};
  assign temp3 ={q3[31:0],16'b0};
  assign q5 =temp2+temp3;
  //stage 2 adders
  assign temp4 ={16'b0,q4[31:0]};
  assign q6 =temp4+q5;
  //output
  assign c[15:0]=q0[15:0];
  assign c[63:16]=q6[47:0];
  endmodule