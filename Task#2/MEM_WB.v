module MEM_WB(
    input clk, reset,
    input [63:0] read_data, Result,
    input EXMEM_MemtoReg, EXMEM_RegWrite,
    input [4:0] EXMEM_inst2,
    output reg [63:0] MEMWB_read_data, MEMWB_Result,
    output reg MEMWB_MemtoReg, MEMWB_RegWrite,
    output reg [4:0] MEMWB_inst2
);
    always @(posedge clk or reset)
    begin
        if(clk)
            begin
                MEMWB_read_data = read_data;
                MEMWB_Result = Result;
                MEMWB_MemtoReg = EXMEM_MemtoReg;
                MEMWB_RegWrite = EXMEM_RegWrite;
                MEMWB_inst2 = EXMEM_inst2;

            end
        else
            begin
                MEMWB_read_data = 0;
                MEMWB_Result = 0;
                MEMWB_MemtoReg = 0;
                MEMWB_RegWrite = 0;
                MEMWB_inst2 = 0;
            end
    end
endmodule