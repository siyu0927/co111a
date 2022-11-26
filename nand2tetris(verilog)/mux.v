`include "gate16.v"

module Mux(input a,b,sel,output out);
 Not g00(sel,notsel);
 And g01(a,notsel,aandnotsel);
 And g02(b,sel,bandnotsel);
 Or g03(aandnotsel,bandnotsel,out);
endmodule

module DMux(input in,sel,output a,b);
 Not g00(sel,nots);
 And g01(in,nots,a);
 And g02(in,sel,b);
endmodule

module Mux16(input [15:0] a,b,input sel,output [15:0] out);
 Mux g15(a[15],b[15],sel,out[15]);
 Mux g14(a[14],b[14],sel,out[14]);
 Mux g13(a[13],b[13],sel,out[13]);
 Mux g12(a[12],b[12],sel,out[12]);
 Mux g11(a[11],b[11],sel,out[11]);
 Mux g10(a[10],b[10],sel,out[10]);
 Mux g09(a[9],b[9],sel,out[9]);
 Mux g08(a[8],b[8],sel,out[8]);
 Mux g07(a[7],b[7],sel,out[7]);
 Mux g06(a[6],b[6],sel,out[6]);
 Mux g05(a[5],b[5],sel,out[5]);
 Mux g04(a[4],b[4],sel,out[4]);
 Mux g03(a[3],b[3],sel,out[3]);
 Mux g02(a[2],b[2],sel,out[2]);
 Mux g01(a[1],b[1],sel,out[1]);
 Mux g00(a[0],b[0],sel,out[0]);
endmodule

module Mux4Way16(input [15:0] a,b,c,d,input [1:0] sel,output [15:0] out);
 wire [15:0] outab,outcd;
 Mux16 g00(a,b,sel[0],outab);
 Mux16 g01(c,d,sel[0],outcd);
 Mux16 g02(outab,outcd,sel[1],out);
endmodule

module Mux8Way16(input [15:0] a,b,c,d,e,f,g,h,input [2:0] sel,output [15:0] out);
 wire [15:0] outad,outeh;
 Mux4Way16 g00(a,b,c,d,sel[1:0],outad);
 Mux4Way16 g01(e,f,g,h,sel[1:0],outeh);
 Mux16 g02(outad,outeh,sel[2],out);
endmodule

module DMux4Way(input in,input [1:0] sel,output a,b,c,d);
 DMux g00(in,sel[1],out1,out2);
 DMux g01(out1,sel[0],a,b);
 DMux g02(out2,sel[0],c,d);
endmodule

module DMux8Way(input in,input [2:0] sel,output a,b,c,d,e,f,g,h);
 DMux g00(in,sel[2],out1,out2);
 DMux4Way g01(out1,sel[1:0],a,b,c,d);
 DMux4Way g02(out2,sel[1:0],e,f,g,h);
endmodule

