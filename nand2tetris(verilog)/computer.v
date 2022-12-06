`include "memory.v"

module Memory(input [15:0] in,input clock,load,input [14:0] address,output [15:0] out);
 wire [15:0] r,s,k,sk;
 Not g00(address[14],a);
 And g01(a,load,ramload);
 And g02(address[14],load,screenload);

 RAM16K g03(in,clock,ramload,address[13:0],r);
 RAM8K g04(in,clock,screenload,address[12:0],s); //screen
 Register g05(16'h0F0F,clock,1'b0,k);//keyboard
 
 Mux16 g06(r,sk,address[14],out);
 Mux16 g07(s,k,address[13],sk);
endmodule

module CPU(input [15:0] inM,instruction,input clock,reset,output [15:0] outM,output writeM,output [14:0] addressM,pc);
 wire [15:0] dout,i1,aout,i2,back,pcout,addressMOut;
 //JUMP
 Or g00(ng,zr,ngzr);
 Not g01(ngzr,gt);
 And g02(ng,instruction[2],passl);
 And g03(zr,instruction[1],passe);
 And g04(gt,instruction[0],passg);
 Or g05(passl,passe,passle);
 Or g06(passle,passg,pass);
 And g07(instruction[15],pass,pcload);

 //D register
 And g08(instruction[15],instruction[4],dload);
 Register g09(back,clock,dload,dout);

 //A register
 Not g10(instruction[15],isA);
 And g11(instruction[15],instruction[5],alutoa);
 Or g12(isA,alutoa,aload);
 Mux16 g13(instruction,back,alutoa,i1);
 Register g14(i1,clock,aload,aout);

 //ALU
 Mux16 g15(aout,inM,instruction[12],i2);
 ALU g16(dout,i2,instruction[11],instruction[10],instruction[9],instruction[8],instruction[7],instruction[6],back,zr,ng);
 PC g17(aout,clock,pcload,1'b1,reset,pcout);

 assign pc = pcout[14:0];

 //OUTPUT
 assign addressM=aout [14:0];
 And g18(instruction[15],instruction[3],writeM);
 And16 g19(back,back,outM);
endmodule

module Computer(input clock,reset);
 wire[15:0] inM, outMemory, instruction;
 wire[14:0] AM, nextinstruction;

 Memory ram(inM,!clock,loadM,AM,outMemory);
 ROM32K rom(nextinstruction,instruction);
 CPU cpu(outMemory,instruction,clock,reset,inM,loadM,AM,nextinstruction);
endmodule

