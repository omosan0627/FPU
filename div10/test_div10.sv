`timescale 1ns / 1ps
`default_nettype none

module test_div10 ();
   logic [31:0] numi;
   wire [31:0]  num;
   wire [31:0]   r;
   wire  [31:0] q;

   int        i;
   int        j;
   logic [3:0]  th;
   logic [27:0] tl;

   assign num = numi;
  
   div10 udiv10(num,q,r);

   initial begin
      $dumpfile("test_div10_32.vcd");
      $dumpvars(0);

      for (i=0;i<10;i++) begin
         for (j=0;j<5;j++) begin
            #1;
            th = $urandom()%10;
            tl = $urandom();
            numi = {th,tl};
            #1;
                $display("q %b %b %d", numi,q, numi/10);
                $display("r %b %b %d", numi,r, numi%10);
         end
      end

      $finish;
   end
endmodule

`default_nettype wire
