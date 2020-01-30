`timescale 1ns / 100ps
`default_nettype none

module test_finv();
   wire [31:0] x,y;
   wire        exception;
   logic [31:0] x1i,x2i;
   shortreal    fx1,fx2,fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] tm;
   bit        fexception;
   bit        checkexception;

   assign x = x1i;
   
   fsqrt u1(x,y);

   initial begin
      // $dumpfile("test_fsqrt.vcd");
      // $dumpvars(0);

      for (i=1; i<256; i++) begin
            for (s1=0; s1<2; s1++) begin
                  for (it=0; it<10; it++) begin
                        #1;

                        case (it)
                          0 : m1 = 23'b0;
                          1 : m1 = {22'b0,1'b1};
                          2 : m1 = {21'b0,2'b10};
                          3 : m1 = {1'b0,3'b111,19'b0};
                          4 : m1 = {1'b1,22'b0};
                          5 : m1 = {2'b10,{21{1'b1}}};
                          6 : m1 = {23{1'b1}};
                          default : begin
                             if (i==256) begin
                                {m1,dum1} = 0;
                             end else begin
                                {m1,dum1} = $urandom();
                             end
                          end
                        endcase
                        
                        x1i = {s1[0],i[7:0],m1};

                        fx1 = $bitstoshortreal(x1i);
                        fy = $sqrt(fx1);
                        fybit = $shortrealtobits(fy);


      if (i == 255 && m1 !== 0) begin
         fexception = 1;
      end else begin
         fexception = 0;
      end
                        
                        #1;

                        
                           $display("%b", x);
                        
                           $display("%b\n", y);
                        
                        
            end
         end
      end

      for (i=1; i<256; i++) begin
         for (s1=0; s1<2; s1++) begin
                  repeat(10000) begin
                     #1;

                     {m1,dum1} = $urandom();
                     x1i = {s1[0],i[7:0],m1};

                     fx1 = $bitstoshortreal(x1i);
                     fy = $sqrt(fx1);
                     fybit = $shortrealtobits(fy);
                     
         if (i == 255 && m1 !== 0) begin
      fexception = 1;
         end else begin
      fexception = 0;
         end

                     #1;

                     
                        $display("%b", x);
                        
                        $display("%b\n", y);
                    
                    
            end
         end
      end
      $display("end of checking module fsqrt");
      $finish;
   end
endmodule

`default_nettype wire
