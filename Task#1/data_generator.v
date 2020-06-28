module data_generator
(
input [31:0] instruction,
output reg [63:0] imm_data

);

wire [6:0] opcode;
assign opcode = instruction[6:0];

always @(*)
begin
    case (opcode)
        7'b0000011: imm_data =  {{52{instruction[31]}}, instruction [31:20]};
        7'b0100011: imm_data = {{52{instruction[31]}}, instruction [31:25], instruction [11:7]};
        7'b1100011: imm_data = {{52{instruction[31]}}, instruction [31] , instruction [7], instruction [30:25], instruction [11:8]};
        7'b0010011: imm_data = {{52{instruction[31]}}, instruction[31:20]};
        default : imm_data = 64'd0;
    endcase
end

endmodule

// reg [63:0] immediate;
// wire [6:0] opcode;
// assign opcode = instruction[6:0];

// always @(instruction)
// begin
//     if(instruction[6]==0) //data transfer
// 	      if(instruction[5]==0) //load
// 	              immediate[11:0] = instruction [31:20];
// 	      else if(instruction[5]==1) //store
// 	              immediate[11:0]= {instruction[31:25],instruction[11:7]};
//     else if(instruction[6]==1) //conditional branches
//         immediate[11:0] = {instruction[31],instruction[7],instruction[30:25] , instruction[11:8]};
// end

// assign imm_data[11:0]= immediate[11:0];
// assign imm_data[63:12] = {52{instruction[31]}};


// endmodule