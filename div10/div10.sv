`timescale 1ns / 1ps
`default_nettype none

module div10_5(
    input wire [4:0] num,
    output wire q5,
    output wire [3:0] r5);

    wire [4:0] w5 = 10;
    assign q5 = (num >= w5) ? 1'b1 : 1'b0;

    wire [4:0] w;
    assign w = (num >= w5) ? (num - w5) : num;
    assign r5= w[3:0];
endmodule

module div10_6(
    input wire [5:0] num,
    output wire [1:0] q6,
    output wire [3:0] r6);

    wire [4:0] pnum = num[5:1];

    wire [3:0] w;

    div10_5 div10_5_1(.num(pnum),.q5(q6[1]), .r5(w));
    div10_5 div10_5_2(.num({w, num[0]}), .q5(q6[0]), .r5(r6));
endmodule


module div10_8(
    input wire [7:0] num,
    output wire [3:0] q8,
    output wire [3:0] r8);

    wire [5:0] pnum = num[7:2];

    wire [3:0] w;

    div10_6 div10_6_1(.num(pnum), .q6(q8[3:2]), .r6(w));
    div10_6 div10_6_2(.num({w, num[1:0]}), .q6(q8[1:0]), .r6(r8));
endmodule

module div10_12(
    input wire [11:0] num,
    output wire [7:0] q12,
    output wire [3:0] r12);

    wire [7:0] pnum = num[11:4];

    wire [3:0] w;

    div10_8 div10_8_1(.num(pnum), .q8(q12[7:4]), .r8(w));
    div10_8 div10_8_2(.num({w, num[3:0]}), .q8(q12[3:0]), .r8(r12));
endmodule

module div10_20(
    input wire [19:0] num,
    output wire [15:0] q20,
    output wire [3:0] r20);

    wire [11:0] pnum = num[19:8];

    wire [3:0] w;

    div10_12 div10_12_1(.num(pnum), .q12(q20[15:8]), .r12(w));
    div10_12 div10_12_2(.num({w, num[7:0]}), .q12(q20[7:0]), .r12(r20));
endmodule

module div10(
    input wire [31:0] num,
    output wire [31:0] q,
    output wire [31:0] r);

    wire [31:0] nnum = (num[31] == 0) ? num : (~num + 1);

    wire [19:0] pnum = nnum[31:12];

    wire [27:0] pq;
    wire [3:0] pr;

    wire [3:0] w;
    wire [3:0] w1;

    div10_20 div10_20_1(.num(pnum), .q20(pq[27:12]), .r20(w));
    div10_12 div10_12_2(.num({w, nnum[11:4]}), .q12(pq[11:4]), .r12(w1));
    div10_8 div10_8_3(.num({w1, nnum[3:0]}), .q8(pq[3:0]), .r8(pr));

    wire [31:0] ppq;
    wire [3:0] ppr;

    assign ppq = {4'b0, pq};
    assign q = (num[31] == 0) ? ppq : 
                (pr == 0) ? (~ppq + 1) : (~ppq);

    assign ppr = (num[31] == 0 || pr == 0) ? pr : (10 - pr);
    assign r = {28'b0, ppr};

endmodule