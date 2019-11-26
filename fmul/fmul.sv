`default_nettype none

module fmul(
    input wire [31:0] x1,
    input wire [31:0] x2,
    output wire [31:0] y,
    output wire ovf);

  wire s1;
  wire s2;
  wire [7:0] e1;
  wire [7:0] e2;
  wire [22:0] m1;
  wire [22:0] m2;

  assign {s1,e1,m1} = x1;
  assign {s2,e2,m2} = x2;

  wire sy;
  assign sy = s1 ^ s2;

  
  wire [23:0] m1a;
  wire [23:0] m2a;

  assign m1a = (e1 == 8'b0) ? {1'b0, m1} : {1'b1, m1};
  assign m2a = (e2 == 8'b0) ? {1'b0, m2} : {1'b1, m2};

  wire [7:0] e1a;
  wire [7:0] e2a;

  assign e1a = (e1 == 8'b0) ? 8'b1 : e1;
  assign e2a = (e2 == 8'b0) ? 8'b1 : e2;

  wire [47:0] mmul;

  assign mmul = {24'b0, m1a} * {24'b0, m2a};
  
  wire [5:0] se;
  assign se = (mmul[47]) ? 0 :
              (mmul[46]) ? 1 :
              (mmul[45]) ? 2 :
              (mmul[44]) ? 3 :
              (mmul[43]) ? 4 :
              (mmul[42]) ? 5 :
              (mmul[41]) ? 6 :
              (mmul[40]) ? 7 :
              (mmul[39]) ? 8 :
              (mmul[38]) ? 9 :
              (mmul[37]) ? 10 :
              (mmul[36]) ? 11 :
              (mmul[35]) ? 12 :
              (mmul[34]) ? 13 :
              (mmul[33]) ? 14 :
              (mmul[32]) ? 15 :
              (mmul[31]) ? 16 :
              (mmul[30]) ? 17 :
              (mmul[29]) ? 18 :
              (mmul[28]) ? 19 :
              (mmul[27]) ? 20 :
              (mmul[26]) ? 21 :
              (mmul[25]) ? 22 :
              (mmul[24]) ? 23 :
              (mmul[23]) ? 24 :
              (mmul[22]) ? 25 :
              (mmul[21]) ? 26 :
              (mmul[20]) ? 27 :
              (mmul[19]) ? 28 :
              (mmul[18]) ? 29 :
              (mmul[17]) ? 30 :
              (mmul[16]) ? 31 :
              (mmul[15]) ? 32 :
              (mmul[14]) ? 33 :
              (mmul[13]) ? 34 :
              (mmul[12]) ? 35 :
              (mmul[11]) ? 36 :
              (mmul[10]) ? 37 :
              (mmul[9]) ? 38 :
              (mmul[8]) ? 39 :
              (mmul[7]) ? 40 :
              (mmul[6]) ? 41 :
              (mmul[5]) ? 42 :
              (mmul[4]) ? 43 :
              (mmul[3]) ? 44 :
              (mmul[2]) ? 45 :
              (mmul[1]) ? 46 :
              (mmul[0]) ? 47 : 48;

  wire [47:0] myft = (mmul[47]) ? mmul :
                      (mmul[46]) ? {mmul[46:0], 1'b0} :
                      (mmul[45]) ? {mmul[45:0], 2'b0} :
                      (mmul[44]) ? {mmul[44:0], 3'b0} :
                      (mmul[43]) ? {mmul[43:0], 4'b0} :
                      (mmul[42]) ? {mmul[42:0], 5'b0} :
                      (mmul[41]) ? {mmul[41:0], 6'b0} :
                      (mmul[40]) ? {mmul[40:0], 7'b0} :
                      (mmul[39]) ? {mmul[39:0], 8'b0} :
                      (mmul[38]) ? {mmul[38:0], 9'b0} :
                      (mmul[37]) ? {mmul[37:0], 10'b0} :
                      (mmul[36]) ? {mmul[36:0], 11'b0} :
                      (mmul[35]) ? {mmul[35:0], 12'b0} :
                      (mmul[34]) ? {mmul[34:0], 13'b0} :
                      (mmul[33]) ? {mmul[33:0], 14'b0} :
                      (mmul[32]) ? {mmul[32:0], 15'b0} :
                      (mmul[31]) ? {mmul[31:0], 16'b0} :
                      (mmul[30]) ? {mmul[30:0], 17'b0} :
                      (mmul[29]) ? {mmul[29:0], 18'b0} :
                      (mmul[28]) ? {mmul[28:0], 19'b0} :
                      (mmul[27]) ? {mmul[27:0], 20'b0} :
                      (mmul[26]) ? {mmul[26:0], 21'b0} :
                      (mmul[25]) ? {mmul[25:0], 22'b0} :
                      (mmul[24]) ? {mmul[24:0], 23'b0} :
                      (mmul[23]) ? {mmul[23:0], 24'b0} :
                      (mmul[22]) ? {mmul[22:0], 25'b0} :
                      (mmul[21]) ? {mmul[21:0], 26'b0} :
                      (mmul[20]) ? {mmul[20:0], 27'b0} :
                      (mmul[19]) ? {mmul[19:0], 28'b0} :
                      (mmul[18]) ? {mmul[18:0], 29'b0} :
                      (mmul[17]) ? {mmul[17:0], 30'b0} :
                      (mmul[16]) ? {mmul[16:0], 31'b0} :
                      (mmul[15]) ? {mmul[15:0], 32'b0} :
                      (mmul[14]) ? {mmul[14:0], 33'b0} :
                      (mmul[13]) ? {mmul[13:0], 34'b0} :
                      (mmul[12]) ? {mmul[12:0], 35'b0} :
                      (mmul[11]) ? {mmul[11:0], 36'b0} :
                      (mmul[10]) ? {mmul[10:0], 37'b0} :
                      (mmul[9]) ? {mmul[9:0], 38'b0} :
                      (mmul[8]) ? {mmul[8:0], 39'b0} :
                      (mmul[7]) ? {mmul[7:0], 40'b0} :
                      (mmul[6]) ? {mmul[6:0], 41'b0} :
                      (mmul[5]) ? {mmul[5:0], 42'b0} :
                      (mmul[4]) ? {mmul[4:0], 43'b0} :
                      (mmul[3]) ? {mmul[3:0], 44'b0} :
                      (mmul[2]) ? {mmul[2:0], 45'b0} :
                      (mmul[1]) ? {mmul[1:0], 46'b0} :
                      (mmul[0]) ? {mmul[0], 47'b0} : 48'b0;

  wire [9:0] eyrt; 
  assign eyrt = {2'b0, e1a} + {2'b0, e2a} - {4'b0, se} - 126;

  wire [7:0] eyr;
  wire [9:0] eyrit;
  wire [7:0] eyri;
  assign eyr = (eyrt[9]) ? 8'b0 : (eyrt[8]) ? 255 : eyrt[7:0];
  assign eyrit = eyrt + 10'b1;
  assign eyri = (eyrit[9]) ? 8'b0 : (eyrit[8]) ? 255 : eyrit[7:0];

  wire [9:0] ss;
  assign ss = ~eyrt + 10'd2;

  wire [70:0] myf;
  wire [24:0] myr;
  assign myf = (eyrt[9]) ? {myft, 23'b0} >> ss[7:0] :
                (~|eyrt) ? {myft, 23'b0} >> 1'b1 : {myft, 23'b0};
  assign myr = (myf[46]) ? {1'b0, myf[70:47]} + 25'b1 : {1'b0, myf[70:47]};

  wire [7:0] ey;
  wire [22:0] my;
  assign ey = (myr[24] == 1'b1) ? eyri : 
              (myr[23] && ~|eyr) ? 8'b1 : 
              (|myr[23:0] == 1'b0) ? 8'b0 : eyr;
  assign my = (myr[24] == 1'b1) ? 23'b0 :
              (myr[23] && ~|eyr) ? {myr[21:0], 1'b0} : myr[22:0];

  assign y =  {sy,ey,my}; 

  assign ovf = (e1 < 8'd255 && e2 < 8'd255 && ey == 8'd255) ? 1'b1 : 1'b0;
  
endmodule

`default_nettype wire
