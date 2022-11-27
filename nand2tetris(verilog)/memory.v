`include "alu.v"

module DFF(input in,clock,output out);
 reg q;
 assign out=q;
 always@(posedge clock)
 begin
    q=in;
 end
endmodule

module Bit(input in,clock,load,output out);
 wire dffin;
 Mux g00(out,in,load,dffin);
 DFF g01(dffin,clock,out);
endmodule

module Register(input [15:0] in,input clock,load,output [15:0] out);
 Bit g00(in[0],clock,load,out[0]);
 Bit g01(in[1],clock,load,out[1]);
 Bit g02(in[2],clock,load,out[2]);
 Bit g03(in[3],clock,load,out[3]);
 Bit g04(in[4],clock,load,out[4]);
 Bit g05(in[5],clock,load,out[5]);
 Bit g06(in[6],clock,load,out[6]);
 Bit g07(in[7],clock,load,out[7]);
 Bit g08(in[8],clock,load,out[8]);
 Bit g09(in[9],clock,load,out[9]);
 Bit g10(in[10],clock,load,out[10]);
 Bit g11(in[11],clock,load,out[11]);
 Bit g12(in[12],clock,load,out[12]);
 Bit g13(in[13],clock,load,out[13]);
 Bit g14(in[14],clock,load,out[14]);
 Bit g15(in[15],clock,load,out[15]);
endmodule

module RAM8(input [15:0] in,input clock,load,input [2:0] address,output [15:0] out);
 wire [15:0] o0,o1,o2,o3,o4,o5,o6,o7;
 DMux8Way g00(load,address,L0,L1,L2,L3,L4,L5,L6,L7);
 Register g01(in,clock,L0,o0);
 Register g02(in,clock,L1,o1);
 Register g03(in,clock,L2,o2);
 Register g04(in,clock,L3,o3);
 Register g05(in,clock,L4,o4);
 Register g06(in,clock,L5,o5);
 Register g07(in,clock,L6,o6);
 Register g08(in,clock,L7,o7);
 Mux8Way16 g09(o0,o1,o2,o3,o4,o5,o6,o7,address,out);
endmodule

module RAM64(input [15:0] in,input clock,load,input [5:0] address,output [15:0] out);
 wire [15:0] o0,o1,o2,o3,o4,o5,o6,o7;
 DMux8Way g00(load,address[5:3],L0,L1,L2,L3,L4,L5,L6,L7);
 RAM8 g01(in,clock,L0,address[2:0],o0);
 RAM8 g02(in,clock,L1,address[2:0],o1);
 RAM8 g03(in,clock,L2,address[2:0],o2);
 RAM8 g04(in,clock,L3,address[2:0],o3);
 RAM8 g05(in,clock,L4,address[2:0],o4);
 RAM8 g06(in,clock,L5,address[2:0],o5);
 RAM8 g07(in,clock,L6,address[2:0],o6);
 RAM8 g08(in,clock,L7,address[2:0],o7);
 Mux8Way16 g09(o0,o1,o2,o3,o4,o5,o6,o7,address[5:3],out);
endmodule

module RAM8K(input [15:0] in,input clock,load,input [12:0] address,output [15:0] out);
 reg [15:0] m[0:2**13-1];
 assign out=m[address];

 always@(posedge clock)
 begin
     if(load) m[address]=in;
 end
endmodule

module RAM16K(input [15:0] in,input clock,load,input [13:0] address,output [15:0] out);
 reg [15:0] m[0:2**14-1];
 assign out=m[address];

 always@(posedge clock)
 begin
     if(load) m[address]=in;
 end
endmodule  

module PC(input [15:0] in,input clock,load,inc,reset,output [15:0] out);
 wire [15:0] o,oinc,om,on,oM;

 Or g00(load,inc,loadinc);
 Or g01(loadinc,reset,loadincreset);

 Inc16 i1(o,oinc);
 And16 g02(o,o,out);

 Mux16 g03(o,oinc,inc,oM);
 Mux16 g04(oM,in,load,om);
 Mux16 g05(om,16'b0,reset,on);
 Register g06(on,clock,loadincreset,o);
endmodule

module ROM32K(input[14:0] address, output[15:0] out);
  reg[15:0] m[0:2**15-1];
  
  assign out = m[address];
endmodule