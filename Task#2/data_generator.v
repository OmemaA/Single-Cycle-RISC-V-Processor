module data_generator
(
input [31:0] instruction,
output [63:0] imm_data

);

reg [63:0] immediate;

assign opcode = instruction[6:0];
always @(instruction)
begin
    if(instruction[6]==0) //data transfer
	      if(instruction[5]==0) //load
	              immediate[11:0] = instruction [31:20];
	      else if(instruction[5]==1) //store
	              immediate[11:0]= {instruction[31:25],instruction[11:7]};
    else if(instruction[6]==1) //conditional branches
        immediate[11:0] = {instruction[31],instruction[7],instruction[30:25] , instruction[11:8]};
end

assign imm_data[11:0]= immediate[11:0];
assign imm_data[63:12] = {52{instruction[31]}};


endmodule
