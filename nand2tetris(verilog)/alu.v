`include "mux.v"

module HalfAdder(input a,b,output sum,carry);
 Xor g00(a,b,sum);
 And g01(a,b,carry);
endmodule

module FullAdder(input a,b,c,output sum,carry);
 Xor g00(a,b,axorb);
 Xor g01(axorb,c,sum);
 And g02(axorb,c,v);
 And g03(a,b,aandb);
 Or g04(v,aandb,carry);
endmodule

module Add16(input [15:0] a,b,output [15:0] out);
 wire [15:0] c;
 FullAdder g00(a[0],b[0],1'b0,out[0],c[0]);
 FullAdder g01(a[1],b[1],c[0],out[1],c[1]);
 FullAdder g02(a[2],b[2],c[1],out[2],c[2]);
 FullAdder g03(a[3],b[3],c[2],out[3],c[3]);
 FullAdder g04(a[4],b[4],c[3],out[4],c[4]);
 FullAdder g05(a[5],b[5],c[4],out[5],c[5]);
 FullAdder g06(a[6],b[6],c[5],out[6],c[6]);
 FullAdder g07(a[7],b[7],c[6],out[7],c[7]);
 FullAdder g08(a[8],b[8],c[7],out[8],c[8]);
 FullAdder g09(a[9],b[9],c[8],out[9],c[9]);
 FullAdder g10(a[10],b[10],c[9],out[10],c[10]);
 FullAdder g11(a[11],b[11],c[10],out[11],c[11]);
 FullAdder g12(a[12],b[12],c[11],out[12],c[12]);
 FullAdder g13(a[13],b[13],c[12],out[13],c[13]);
 FullAdder g14(a[14],b[14],c[13],out[14],c[14]);
 FullAdder g15(a[15],b[15],c[14],out[15],c[15]);
endmodule

module Inc16(input [15:0] in,output [15:0] out);
 wire [15:0] c;
 HalfAdder g00(in[0],1'b1,out[0],c[0]);
 HalfAdder g01(in[1],c[0],out[1],c[1]);
 HalfAdder g02(in[2],c[1],out[2],c[2]);
 HalfAdder g03(in[3],c[2],out[3],c[3]);
 HalfAdder g04(in[4],c[3],out[4],c[4]);
 HalfAdder g05(in[5],c[4],out[5],c[5]);
 HalfAdder g06(in[6],c[5],out[6],c[6]);
 HalfAdder g07(in[7],c[6],out[7],c[7]);
 HalfAdder g08(in[8],c[7],out[8],c[8]);
 HalfAdder g09(in[9],c[8],out[9],c[9]);
 HalfAdder g10(in[10],c[9],out[10],c[10]);
 HalfAdder g11(in[11],c[10],out[11],c[11]);
 HalfAdder g12(in[12],c[11],out[12],c[12]);
 HalfAdder g13(in[13],c[12],out[13],c[13]);
 HalfAdder g14(in[14],c[13],out[14],c[14]);
 HalfAdder g15(in[15],c[14],out[15],c[15]);
endmodule

module ALU(input [15:0] x,y,input zx,nx,zy,ny,f,no,output [15:0] out,output zr,ng);
 wire [15:0] o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11;
 wire orlow,orhigh,nzr;
 Mux16 g00(x,16'b0,zx,o1);
 Not16 g01(o1,o2);
 Mux16 g02(o1,o2,nx,o3);

 Mux16 g03(y,16'b0,zy,o4);
 Not16 g04(o4,o5);
 Mux16 g05(o4,o5,ny,o6);

 Add16 g06(o3,o6,o7);
 And16 g07(o3,o6,o8);

 Mux16 g08(o8,o7,f,o9);
 Not16 g09(o9,o10);

 Mux16 g10(o9,o10,no,o11);

 And16 g11(o11,o11,out);
 Or8Way g12(out[7:0],orlow);
 Or8Way g13(out[15:8],orhigh);
 Or g14(orlow,orhigh,nzr);
 Not g15(nzr,zr);
 And g16(o11[15],o11[15],ng);
 And16 g17(o11,o11,out);
endmodule