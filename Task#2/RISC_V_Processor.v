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
//Output from Data memory
wire [63:0] out_from_DM;
//Output from mux3
wire [63:0] out_from_mux3;
//Outputs from IF_ID
wire [31:0] IFID_instruction;
wire [63:0] IFID_PC_Out;
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;
//Outputs from ID_EX
wire [63:0] IDEX_PC_Out;
wire [63:0] IDEX_ReadData1;
wire [63:0] IDEX_ReadData2;
wire [63:0] IDEX_imm_data;
wire [3:0] IDEX_inst1;
wire [4:0] IDEX_inst2;
wire [1:0] IDEX_ALUOp;
wire IDEX_Branch, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_ALUSrc, IDEX_Regwrite;
//Input to Adder a2
wire [63:0] b_adder2;
assign b_adder2 = IDEX_imm_data << 1;
//Outputs from EX_MEM
wire [63:0] EXMEM_out;
wire EXMEM_ZERO;
wire [63:0] EXMEM_Result;
wire [63:0] EXMEM_ReadData2;
wire [4:0] EXMEM_inst2;
wire EXMEM_Branch, EXMEM_MemRead, EXMEM_MemtoReg, EXMEM_MemWrite, EXMEM_RegWrite;
//Outputs from MEM_WB
wire [63:0] MEMWB_read_data;
wire [63:0] MEMWB_Result;
wire MEMWB_MemtoReg, MEMWB_RegWrite;
wire [4:0] MEMWB_inst2;
//sel to mux1
wire PC_src;

//addi x5, x0, 3
IF_ID ifid
        (.clk(clk), 
        .reset(reset), 
        .instruction(Instruction), 
        .PC_Out(PC_Out),
        .IFID_instruction(IFID_instruction), 
        .IFID_PC_Out(IFID_PC_Out));

ID_EX idex
        (.clk(clk),
         .reset(reset), 
         .ALUOp(ALUOp), 
         .Branch(Branch), 
         .MemRead(MemRead), 
         .MemtoReg(MemtoReg), 
         .MemWrite(MemWrite), 
         .ALUSrc(ALUSrc), 
         .RegWrite(RegWrite),
         .ReadData1(ReadData1), 
         .ReadData2(ReadData2), 
         .PC_Out(IFID_PC_Out), 
         .imm_data(imm_data), 
         .inst1({IFID_instruction[30], IFID_instruction[14:12]}), 
         .inst2(rd),

         .IDEX_Branch(IDEX_Branch), 
         .IDEX_MemRead(IDEX_MemRead), 
         .IDEX_MemtoReg(IDEX_MemtoReg), 
         .IDEX_MemWrite(IDEX_MemWrite), 
         .IDEX_ALUSrc(IDEX_ALUSrc), 
         .IDEX_Regwrite(IDEX_Regwrite), 
         .IDEX_ALUOp(IDEX_ALUOp),
         .IDEX_ReadData1(IDEX_ReadData1), 
         .IDEX_ReadData2(IDEX_ReadData2), 
         .IDEX_PC_Out(IDEX_PC_Out), 
         .IDEX_imm_data(IDEX_imm_data),
         .IDEX_inst1(IDEX_inst1),
         .IDEX_inst2(IDEX_inst2));
         


EX_MEM exmem(.clk(clk), 
            .reset(reset), 
            .IDEX_Branch(IDEX_Branch),
            .IDEX_MemRead(IDEX_MemRead),
            .IDEX_MemtoReg(IDEX_MemtoReg),
            .IDEX_MemWrite(IDEX_MemWrite),
            .IDEX_Regwrite(IDEX_Regwrite),
            .out(a2_out), 
            .ZERO(zero_output),
            .Result(Result_from_alu), 
            .IDEX_ReadData2(IDEX_ReadData2), 
            .IDEX_inst2(IDEX_inst2),
            
            .EXMEM_out(EXMEM_out), 
            .EXMEM_Result(EXMEM_Result), 
            .EXMEM_ReadData2(EXMEM_ReadData2), 
            .EXMEM_inst2(EXMEM_inst2),
            .EXMEM_ZERO(EXMEM_ZERO),  
            .EXMEM_Branch(EXMEM_Branch), 
            .EXMEM_MemRead(EXMEM_MemRead),
            .EXMEM_MemtoReg(EXMEM_MemtoReg), 
            .EXMEM_MemWrite(EXMEM_MemWrite), 
            .EXMEM_Regwrite(EXMEM_RegWrite));


MEM_WB memwb(.clk(clk), 
             .reset(reset), 
             .EXMEM_MemtoReg(EXMEM_MemtoReg),
             .EXMEM_RegWrite(EXMEM_RegWrite),
             .read_data(out_from_DM), 
             .Result(EXMEM_Result), 
             .EXMEM_inst2(EXMEM_inst2),
            
             .MEMWB_read_data(MEMWB_read_data), 
             .MEMWB_Result(MEMWB_Result),
             .MEMWB_MemtoReg(MEMWB_MemtoReg),
             .MEMWB_RegWrite(MEMWB_RegWrite),
             .MEMWB_inst2(MEMWB_inst2));

Instruction_Parser ip
        (.instruction(IFID_instruction), 
        .rd(rd), 
        .rs1(rs1), 
        .rs2(rs2), 
        .funct3(funct3), 
        .funct7(funct7), 
        .opcode(opcode));

Program_Counter pc 
            (.clk(clk), 
            .reset(reset), 
            .PC_In(PC_In_from_mux), 
            .PC_Out(PC_Out));

Adder a1 
        (.a(PC_Out), 
        .b(b_in), 
        .out(a1_out));

Adder a2
        (.a(IDEX_PC_Out), 
        .b(b_adder2), 
        .out(a2_out));

mux2x1 mux1
        (.a(a1_out), 
        .b(EXMEM_out), 
        .s(PC_src), 
        .data_out(PC_In_from_mux));

mux2x1 mux2
        (.a(IDEX_ReadData2), 
        .b(IDEX_imm_data), 
        .s(IDEX_ALUSrc), 
        .data_out(out_from_mux2));

mux2x1 mux3
        (.b(MEMWB_read_data), 
        .a(MEMWB_Result), 
        .s(MEMWB_MemtoReg), 
        .data_out(out_from_mux3));

Instruction_Memory im
        (.Inst_Address(PC_Out), 
        .Instruction(Instruction));

registerFile rf
        (.WriteData(out_from_mux3), 
        .RS1(rs1), 
        .RS2(rs2),
        .RD(MEMWB_inst2), 
        .clk(clk), 
        .reset(reset), 
        .RegWrite(MEMWB_RegWrite), 
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2));

Control_Unit cu
        (.Opcode(opcode), 
        .ALUOp(ALUOp), 
        .Branch(Branch), 
        .MemRead(MemRead), 
        .MemtoReg(MemtoReg), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc),
        .Regwrite(RegWrite));

ALU_Control aluc
        (.ALUOp(IDEX_ALUOp), 
        .Funct(IDEX_inst1), 
        .Operation(Operation));

data_generator dg
        (.instruction(IFID_instruction), 
        .imm_data(imm_data));

alu_64 alu 
        (.a(IDEX_ReadData1), 
        .b(out_from_mux2), 
        .ALUOp(Operation), 
        .Result(Result_from_alu), 
        .ZERO(zero_output));

selector s
        (.branch(EXMEM_Branch), 
        .ZERO(EXMEM_ZERO), 
        .a(IDEX_ReadData1), 
        .b(out_from_mux2),
        .funct3(funct3), 
        .sel(PC_src)
        );

Data_Memory dm
        (.mem_addr(EXMEM_Result), 
        .write_data(EXMEM_ReadData2), 
        .clk(clk), 
        .mem_write(EXMEM_MemWrite), 
        .mem_read(EXMEM_MemRead), 
        .read_data(out_from_DM));




always @(posedge clk)
    begin
        $monitor(
        "PC_In = ", PC_In_from_mux, 
        ", PC_Out = ", PC_Out, 
        ", Instruction = %b", Instruction,
        ", Opcode = %b", opcode, 
        ", Funct3 = %b", funct3, 
        ", rs1 = %d", rs1, 
        ", rs2 = %d", rs2, 
        ", rd = %d", rd,
        ", funct7 = %b", IFID_instruction[31:25], 
        ", ALUOp = %b", IDEX_ALUOp,
        ", imm_data = %d", imm_data,
        ", Operation = %b", Operation 
        );
    end
endmodule
