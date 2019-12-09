`default_nettype none

module fle(
  input wire [31:0] x1,
  input wire [31:0] x2,
  output wire [31:0] y);
  
  wire s1;
  wire s2;
  wire [7:0] e1;
  wire [7:0] e2;
  wire [22:0] m1;  
  wire [22:0] m2;
     
  assign {s1, e1, m1} = x1;
  assign {s2, e2, m2} = x2;
  
  wire py = (x1 <= x2)? 1'b1 : 1'b0;
  
  wire nzm1 = |m1;
  wire nzm2 = |m2;

  assign ty = (e2 == 8'd255 && nzm2) ? 1'b0 :
              (e1 == 8'd255 && nzm1) ? 1'b0 :
              (e1 == 8'b0 && m1 == 8'b0 && e2 == 8'b0 && m2 == 8'b0) ? 1'b1 : 
              ((s1 == 1'b1 || s2 == 1'b1) && x1 != x2) ? ~py : py;

  assign y = {31'b0, ty};
  
endmodule 

`default_nettype wire