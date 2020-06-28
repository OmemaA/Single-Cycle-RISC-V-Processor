module Instruction_Memory(
    input [63:0] Inst_Address,
    output reg [31:0] Instruction
);
reg [7:0] inst_memory [131:0];

initial
begin
    
    inst_memory[0] = 8'b10000011;
    inst_memory[1] = 8'b00110100;
    inst_memory[2] = 8'b10000101;
    inst_memory[3] = 8'b00000010;


    // inst_memory[0] = 8'b10010011;
    // inst_memory[1] = 8'b00000010;
    // inst_memory[2] = 8'b00110000;
    // inst_memory[3] = 8'b00000000;

    // inst_memory[4] = 8'b00100011;
    // inst_memory[5] = 8'b00110010;
    // inst_memory[6] = 8'b01010000;
    // inst_memory[7] = 8'b00000000;

    // inst_memory[8] = 8'b10010011;
    // inst_memory[9] = 8'b00000010;
    // inst_memory[10] = 8'b00100000;
    // inst_memory[11] = 8'b00000000;
    
    // inst_memory[12] = 8'b00100011;
    // inst_memory[13] = 8'b00110110;
    // inst_memory[14] = 8'b01010000;
    // inst_memory[15] = 8'b00000000;
    
    // inst_memory[16] = 8'b10010011;
    // inst_memory[17] = 8'b00000010;
    // inst_memory[18] = 8'b10100000;
    // inst_memory[19] = 8'b00000000;
    
    // inst_memory[20] = 8'b00100011;
    // inst_memory[21] = 8'b00111010;
    // inst_memory[22] = 8'b01010000;
    // inst_memory[23] = 8'b00000000;
    
    // inst_memory[24] = 8'b00010011;
    // inst_memory[25] = 8'b00000101;
    // inst_memory[26] = 8'b01000000;
    // inst_memory[27] = 8'b00000000;
    
    // inst_memory[28] = 8'b10010011;
    // inst_memory[29] = 8'b00000101;
    // inst_memory[30] = 8'b00110000;
    // inst_memory[31] = 8'b00000000;
    
    // inst_memory[32] = 8'b01100011;
    // inst_memory[33] = 8'b00010110;
    // inst_memory[34] = 8'b00000101;
    // inst_memory[35] = 8'b00000000;
    
    // //bne 101
    // inst_memory[36] = 8'b01100011;
    // inst_memory[37] = 8'b10010100;
    // inst_memory[38] = 8'b00000101;
    // inst_memory[39] = 8'b00000000;

    // //beq 011
    // inst_memory[40] = 8'b01100011;
    // inst_memory[41] = 8'b00001100;
    // inst_memory[42] = 8'b00000000;
    // inst_memory[43] = 8'b00000100;
    
    // inst_memory[44] = 8'b00010011;
    // inst_memory[45] = 8'b00001001;
    // inst_memory[46] = 8'b00000000;
    // inst_memory[47] = 8'b00000000;
    
    // inst_memory[48] = 8'b01100011;
    // inst_memory[49] = 8'b00000110;
    // inst_memory[50] = 8'b10111001;
    // inst_memory[51] = 8'b00000100;
    
    // inst_memory[52] = 8'b10110011;
    // inst_memory[53] = 8'b00001001;
    // inst_memory[54] = 8'b00100000;
    // inst_memory[55] = 8'b00000001;
    
    // inst_memory[56] = 8'b01100011;
    // inst_memory[57] = 8'b10001110;
    // inst_memory[58] = 8'b10111001;
    // inst_memory[59] = 8'b00000010;
    
    // inst_memory[60] = 8'b10010011;
    // inst_memory[61] = 8'b00010010;
    // inst_memory[62] = 8'b00111001;
    // inst_memory[63] = 8'b00000000;
    
    // inst_memory[64] = 8'b00010011;
    // inst_memory[65] = 8'b10010011;
    // inst_memory[66] = 8'b00111001;
    // inst_memory[67] = 8'b00000000;
    
    // inst_memory[68] = 8'b10110011;
    // inst_memory[69] = 8'b10000010;
    // inst_memory[70] = 8'b10100010;
    // inst_memory[71] = 8'b00000000;
    
    // inst_memory[72] = 8'b00110011;
    // inst_memory[73] = 8'b00000011;
    // inst_memory[74] = 8'b10100011;
    // inst_memory[75] = 8'b00000000;
    
    // inst_memory[76] = 8'b00000011;
    // inst_memory[77] = 8'b10111110;
    // inst_memory[78] = 8'b00000010;
    // inst_memory[79] = 8'b00000000;
    
    // inst_memory[80] = 8'b10000011;
    // inst_memory[81] = 8'b00111110;
    // inst_memory[82] = 8'b00000011;
    // inst_memory[83] = 8'b00000000;
    // //bge 111
    // inst_memory[84] = 8'b01100011;
    // inst_memory[85] = 8'b01011100;
    // inst_memory[86] = 8'b11011110;
    // inst_memory[87] = 8'b00000001;
    
    // inst_memory[88] = 8'b00110011;
    // inst_memory[89] = 8'b00001111;
    // inst_memory[90] = 8'b11000000;
    // inst_memory[91] = 8'b00000001;
    
    // inst_memory[92] = 8'b00110011;
    // inst_memory[93] = 8'b00001110;
    // inst_memory[94] = 8'b11010000;
    // inst_memory[95] = 8'b00000001;
    
    // inst_memory[96] = 8'b10110011;
    // inst_memory[97] = 8'b00001110;
    // inst_memory[98] = 8'b11100000;
    // inst_memory[99] = 8'b00000001;
    
    // inst_memory[100] =8'b00100011;
    // inst_memory[101] =8'b10110000;
    // inst_memory[102] =8'b11000010;
    // inst_memory[103] =8'b00000001;
    
    // inst_memory[104] =8'b00100011;
    // inst_memory[105] =8'b00110000;
    // inst_memory[106] =8'b11010011;
    // inst_memory[107] =8'b00000001;
    
    // inst_memory[108] =8'b10010011;
    // inst_memory[109] =8'b10001001;
    // inst_memory[110] =8'b00011001;
    // inst_memory[111] =8'b00000000;
    
    // inst_memory[112] =8'b11100011;
    // inst_memory[113] =8'b00000100;
    // inst_memory[114] =8'b00000000;
    // inst_memory[115] =8'b11111100;
    
    // inst_memory[116] =8'b00010011; 
    // inst_memory[117] =8'b00001001;
    // inst_memory[118] =8'b00011001;
    // inst_memory[119] =8'b00000000;

    // inst_memory[120] =8'b11100011;
    // inst_memory[121] =8'b00001100;
    // inst_memory[122] =8'b00000000;
    // inst_memory[123] =8'b11111010;
    
    // inst_memory[124] =8'b01100011;
    // inst_memory[125] =8'b00000010;   
    // inst_memory[126] =8'b00000000;
    // inst_memory[127] =8'b00000000;
    
    // inst_memory[128] =8'b00010011;
    // inst_memory[129] =8'b00000000;
    // inst_memory[130] =8'b00000000;
    // inst_memory[131] =8'b00000000;
    
end
always@(Inst_Address)
    Instruction = {inst_memory[Inst_Address+3],inst_memory[Inst_Address+2],inst_memory[Inst_Address+1], inst_memory[Inst_Address]};
endmodule