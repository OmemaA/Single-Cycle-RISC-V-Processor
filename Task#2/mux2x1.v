module mux2x1
(
    input [63:0] a,b,
    input s ,
    output [63:0] data_out
);

assign data_out = s ? b : a;

endmodule
