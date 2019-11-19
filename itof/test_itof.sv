`timescale 1ns / 100ps
`default_nettype none

module test_itof();
   wire signed [31:0] x;
   wire [31:0] y;
   wire        exception;
   int          xi;
   shortreal    fy,max,min;
   int          fx;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] tm;

   assign x = xi;
   
   itof u1(x,y);

   initial begin
      // $dumpfile("test_itof.vcd");
      // $dumpvars(0);

      max = $bitstoshortreal({1'b0,8'd158,23'b0});
      min = $bitstoshortreal({1'b1,8'd158,23'b0});

      for (i=0; i<256; i++) begin
         for (j=0; j<256; j++) begin
            for (s1=0; s1<2; s1++) begin
               for (s2=0; s2<2; s2++) begin
                  for (it=0; it<10; it++) begin
                     for (jt=0; jt<10; jt++) begin
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
                        
                        xi = {s1[0],i[7:0],m1};
                        fy = xi;
                        fybit = $shortrealtobits(fy);
         
                        #1;

                        if (y !== fybit) begin
                           $display("%d %b", xi,xi);
                           $display("%e %b %d %b", fy, fybit[31], fybit[30:23], fybit[22:0]);
                           $display("%e %b %d %b\n", $bitstoshortreal(y), y[31], y[30:23], y[22:0]);
                        end
                     end
                  end
               end
            end
         end
      end

      for (i=0; i<255; i++) begin
         for (s1=0; s1<2; s1++) begin
            for (s2=0; s2<2; s2++) begin
               for (j=0;j<23;j++) begin
                  repeat(10) begin
                     #1;

                     {m1,dum1} = $urandom();
                     xi = {s1[0],i[7:0],m1};
                     {m2,dum2} = $urandom();
                     for (k=0;k<j;k++) begin
                        tm[k] = m2[k];
                     end
                     for (k=j;k<23;k++) begin
                        tm[k] = m1[k];
                     end

                     fy = xi;
                     fybit = $shortrealtobits(fy);

                     #1;

                     if (y !== fybit) begin
                        $display("%d %b", xi,xi);
                        $display("%e %b %d %b", fy, fybit[31], fybit[30:23], fybit[22:0]);
                        $display("%e %b %d %b\n", $bitstoshortreal(y), y[31], y[30:23], y[22:0]);
                     end
                  end
               end
            end
         end
      end
      $display("end of checking module itof");
      $finish;
   end
endmodule

`default_nettype wire