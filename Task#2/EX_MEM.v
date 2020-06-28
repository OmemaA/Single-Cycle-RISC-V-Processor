module EX_MEM(
    input clk, reset, ZERO,
    input [63:0] out, Result, IDEX_ReadData2,
    input [4:0] IDEX_inst2,
    input IDEX_Branch, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_Regwrite,
    output reg EXMEM_ZERO,
    output reg [4:0] EXMEM_inst2,
    output reg [63:0] EXMEM_out, EXMEM_Result, EXMEM_ReadData2,
    output reg EXMEM_Branch, EXMEM_MemRead, EXMEM_MemtoReg, EXMEM_MemWrite, EXMEM_Regwrite
);

    always @(posedge clk or reset)
    begin
        if(clk)
           begin
                EXMEM_out = out;
                EXMEM_ZERO = ZERO;
                EXMEM_Result = Result;
                EXMEM_ReadData2 = IDEX_ReadData2;
                EXMEM_inst2 = IDEX_inst2;
                EXMEM_Branch = IDEX_Branch;
                EXMEM_MemRead = IDEX_MemRead;
                EXMEM_MemtoReg= IDEX_MemtoReg;
                EXMEM_MemWrite= IDEX_MemWrite;
                EXMEM_Regwrite= IDEX_Regwrite;
            end
        else
            begin
                EXMEM_out = 0;
                EXMEM_ZERO = 0;
                EXMEM_Result = 0;
                EXMEM_ReadData2 = 0;
                EXMEM_inst2 = 0;
                EXMEM_Branch = 0;
                EXMEM_MemRead = 0;
                EXMEM_MemtoReg= 0;
                EXMEM_MemWrite= 0;
                EXMEM_Regwrite=0;
            end
    end
endmodule
