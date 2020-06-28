module RISC_V_Processor(
    input clk, reset
);

//Mux output
wire [63:0] PC_In_from_mux;
//Program counter output
wire [63:0] PC_Out;
//Adders outputs
wire [63:0] a1_out;
wire [63:0] a2_out;
//Input to Adder a1
wire [63:0] b_in = 64'd4;
//Output from IM
wire [31:0] Instruction;
//Output from IP
wire [4:0] rd; 
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;
//Outputs from RegisterFile
wire [63:0] ReadData1;
wire [63:0] ReadData2;
//Outputs from Control Unit
wire [1:0] ALUOp;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
//Outputs from ALU Control
wire [3:0] Operation;
//Funct input to ALU_Control
wire [3:0] Funct;
assign Funct = {Instruction[30], Instruction[14:12]};
//Output from ALU
wire [63:0] Result_from_alu;
wire zero_output;
//Output from Data generator
wire [63:0] imm_data;
//Output from mux2
wire [63:0] out_from_mux2;
//sel for mux1
wire sel;
//Output from Data memory
wire [63:0] out_from_DM;
//Output from mux3
wire [63:0] out_from_mux3;
//Input to Adder a2
wire [63:0] b_adder2;
assign b_adder2 = imm_data << 1;

Program_Counter pc (.clk(clk), .reset(reset), .PC_In(PC_In_from_mux), .PC_Out(PC_Out));

Adder a1 (.a(PC_Out), .b(b_in), .out(a1_out));

Adder a2(.a(PC_Out), .b(b_adder2), .out(a2_out));

mux2x1 mux1(.a(a1_out), .b(a2_out), .s(sel), .data_out(PC_In_from_mux));

Instruction_Memory im(.Inst_Address(PC_Out), .Instruction(Instruction));

Instruction_Parser ip(.instruction(Instruction), .rd(rd), .rs1(rs1), .rs2(rs2), .funct3(funct3), .funct7(funct7), .opcode(opcode));

registerFile rf(.WriteData(out_from_mux3), .RS1(rs1), .RS2(rs2), .RD(rd), .clk(clk), .reset(reset), .RegWrite(RegWrite), .ReadData1(ReadData1), .ReadData2(ReadData2));

Control_Unit cu(
    .Opcode(opcode), 
    .ALUOp(ALUOp), 
    .Branch(Branch), 
    .MemRead(MemRead), 
    .MemtoReg(MemtoReg), 
    .MemWrite(MemWrite), 
    .ALUSrc(ALUSrc), 
    .Regwrite(RegWrite));

ALU_Control aluc(
    .ALUOp(ALUOp), 
    .Funct(Funct), 
    .Operation(Operation));

data_generator dg(
    .instruction(Instruction), 
    .imm_data(imm_data));

mux2x1 mux2(
    .a(ReadData2), 
    .b(imm_data), 
    .s(ALUSrc), 
    .data_out(out_from_mux2));

alu_64 alu(
    .a(ReadData1), 
    .b(out_from_mux2), 
    .ALUOp(Operation), 
    .Result(Result_from_alu), 
    .ZERO(zero_output));

selector s(
    .branch(Branch), 
    .ZERO(zero_output), 
    .a(ReadData1), 
    .b(out_from_mux2), 
    .funct3(funct3), 
    .sel(sel));

Data_Memory dm(.mem_addr(Result_from_alu), .write_data(ReadData2), .clk(clk), .mem_write(MemWrite), .mem_read(MemRead), .read_data(out_from_DM));

mux2x1 mux3(
    .b(out_from_DM), 
    .a(Result_from_alu), 
    .s(MemtoReg), 
    .data_out(out_from_mux3));

always @(posedge clk)
    begin
        $monitor(
        "PC_In = ", PC_In_from_mux, 
        ", PC_Out = ", PC_Out, 
        ", Instruction = %b", Instruction,
        ", Opcode = %b", opcode, 
        ", Funct3 = %b", funct3, 
        ", Zero = %b", zero_output,
        ", Branch = %d", Branch,
        ", sel = %d", sel,
        ", rs1 = %d", rs1, 
        ", rs2 = %d", rs2, 
        ", rd = %d", rd,
        ", funct7 = %b", funct7, 
        ", ALUOp = %b", ALUOp,
        ", imm_data = %d", imm_data,
        ", Operation = %b", Operation 
        );
    end
endmodule
