module fetch(clk,f_pc,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,predicted_PC,mem_error,halt,valid_inst);

input clk;
input [64:1] f_pc;

output reg [4:1] f_icode;
output reg [4:1] f_ifun;
output reg [4:1] f_rA;
output reg [4:1] f_rB;


output reg[63:0] f_valC;
output reg[63:0] f_valP;
output reg[63:0] predicted_PC;

//status codes

output reg valid_inst;
output reg halt;
output reg mem_error;


reg [7:0] instruction_memory [0:100];

initial begin
    
    halt = 0;
        // prog 0
        // instruction_memory[0] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 1

        // instruction_memory[1] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[2] = 8'b11110110; // F, rB = 6;
        // instruction_memory[3] = 8'b00000001; // 1st byte of V = 1, rest all bytes will be zero
        // instruction_memory[4] = 8'b00000000;
        // instruction_memory[5] = 8'b00000000;
        // instruction_memory[6] = 8'b00000000;
        // instruction_memory[7] = 8'b00000000;
        // instruction_memory[8] = 8'b00000000;
        // instruction_memory[9] = 8'b00000000;
        // instruction_memory[10] = 8'b00000000;

        // instruction_memory[11] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 21 
        // instruction_memory[12] = 8'b11110001; // F, rB = 1;
        // instruction_memory[13] = 8'b00000010; // 1st byte of V = 2, rest all bytes will be zero
        // instruction_memory[14] = 8'b00000000;
        // instruction_memory[15] = 8'b00000000;
        // instruction_memory[16] = 8'b00000000;
        // instruction_memory[17] = 8'b00000000;
        // instruction_memory[18] = 8'b00000000;
        // instruction_memory[19] = 8'b00000000;
        // instruction_memory[20] = 8'b00000000;

        // instruction_memory[21] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 31 
        // instruction_memory[22] = 8'b11110011; // F, rB = 3;
        // instruction_memory[23] = 8'b00000100; // 1st byte of V = 4, rest all bytes will be zero
        // instruction_memory[24] = 8'b00000000;
        // instruction_memory[25] = 8'b00000000;
        // instruction_memory[26] = 8'b00000000;
        // instruction_memory[27] = 8'b00000000;
        // instruction_memory[28] = 8'b00000000;
        // instruction_memory[29] = 8'b00000000;
        // instruction_memory[30] = 8'b00000000;

        // instruction_memory[31] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 41 
        // instruction_memory[32] = 8'b11110100; // F, rB = 4;
        // instruction_memory[33] = 8'b00000101; // 1st byte of V = 5, rest all bytes will be zero
        // instruction_memory[34] = 8'b00000000;
        // instruction_memory[35] = 8'b00000000;
        // instruction_memory[36] = 8'b00000000;
        // instruction_memory[37] = 8'b00000000;
        // instruction_memory[38] = 8'b00000000;
        // instruction_memory[39] = 8'b00000000;
        // instruction_memory[40] = 8'b00000000;

        // instruction_memory[41] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 42
        // instruction_memory[42] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 43
        // instruction_memory[43] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 44
        // instruction_memory[44] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 45
        // instruction_memory[45] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 46
        
        // instruction_memory[46] = 8'b00000000;

        // // prog1
        // instruction_memory[0] = 8'b00010000; 

        // instruction_memory[1] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[2] = 8'b11110001; // F, rB = 1;
        // instruction_memory[3] = 8'b00000010; // 1st byte of V = 2, rest all bytes will be zero
        // instruction_memory[4] = 8'b00000000;
        // instruction_memory[5] = 8'b00000000;
        // instruction_memory[6] = 8'b00000000;
        // instruction_memory[7] = 8'b00000000;
        // instruction_memory[8] = 8'b00000000;
        // instruction_memory[9] = 8'b00000000;
        // instruction_memory[10] = 8'b00000000;

        // instruction_memory[11] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[12] = 8'b11110010; // F, rB = 2;
        // instruction_memory[13] = 8'b00000011; // 1st byte of V = 3, rest all bytes will be zero
        // instruction_memory[14] = 8'b00000000;
        // instruction_memory[15] = 8'b00000000;
        // instruction_memory[16] = 8'b00000000;
        // instruction_memory[17] = 8'b00000000;
        // instruction_memory[18] = 8'b00000000;
        // instruction_memory[19] = 8'b00000000;
        // instruction_memory[20] = 8'b00000000;

        // instruction_memory[21] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 22
        // instruction_memory[22] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 23
        // instruction_memory[23] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 24

        // instruction_memory[24] = 8'b01100000; // Opq add // PC = PC + 2 = 26
        // instruction_memory[25] = 8'b00010010; // rA = 1 and rB = 2, final value in rB(2) = 5;

        // instruction_memory[26] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 27
        // instruction_memory[27] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 28
        // instruction_memory[28] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 29
        // instruction_memory[29] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 30
        // instruction_memory[30] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 31
        
        // instruction_memory[31] = 8'b00000000; // halt instruction


        // // prog2
        // instruction_memory[0] = 8'b00010000; 

        // instruction_memory[1] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[2] = 8'b11110001; // F, rB = 1;
        // instruction_memory[3] = 8'b00000010; // 1st byte of V = 2, rest all bytes will be zero
        // instruction_memory[4] = 8'b00000000;
        // instruction_memory[5] = 8'b00000000;
        // instruction_memory[6] = 8'b00000000;
        // instruction_memory[7] = 8'b00000000;
        // instruction_memory[8] = 8'b00000000;
        // instruction_memory[9] = 8'b00000000;
        // instruction_memory[10] = 8'b00000000;

        // instruction_memory[11] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[12] = 8'b11110010; // F, rB = 2;
        // instruction_memory[13] = 8'b00000011; // 1st byte of V = 3, rest all bytes will be zero
        // instruction_memory[14] = 8'b00000000;
        // instruction_memory[15] = 8'b00000000;
        // instruction_memory[16] = 8'b00000000;
        // instruction_memory[17] = 8'b00000000;
        // instruction_memory[18] = 8'b00000000;
        // instruction_memory[19] = 8'b00000000;
        // instruction_memory[20] = 8'b00000000;

        // instruction_memory[21] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 22
        // instruction_memory[22] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 23

        // instruction_memory[23] = 8'b01100000; // Opq add // PC = PC + 2 = 25
        // instruction_memory[24] = 8'b00010010; // rA = 1 and rB = 2, final value in rB(2) = 5;

        // instruction_memory[25] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 26
        // instruction_memory[26] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 27
        // instruction_memory[27] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 28
        // instruction_memory[28] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 29

        // instruction_memory[29] = 8'b00000000; // halt instruction

        // //prog3
        // instruction_memory[0] = 8'b00010000; 

        // instruction_memory[1] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[2] = 8'b11110001; // F, rB = 1;
        // instruction_memory[3] = 8'b00000010; // 1st byte of V = 2, rest all bytes will be zero
        // instruction_memory[4] = 8'b00000000;
        // instruction_memory[5] = 8'b00000000;
        // instruction_memory[6] = 8'b00000000;
        // instruction_memory[7] = 8'b00000000;
        // instruction_memory[8] = 8'b00000000;
        // instruction_memory[9] = 8'b00000000;
        // instruction_memory[10] = 8'b00000000;

        // instruction_memory[11] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[12] = 8'b11110010; // F, rB = 2;
        // instruction_memory[13] = 8'b00000011; // 1st byte of V = 3, rest all bytes will be zero
        // instruction_memory[14] = 8'b00000000;
        // instruction_memory[15] = 8'b00000000;
        // instruction_memory[16] = 8'b00000000;
        // instruction_memory[17] = 8'b00000000;
        // instruction_memory[18] = 8'b00000000;
        // instruction_memory[19] = 8'b00000000;
        // instruction_memory[20] = 8'b00000000;

        // instruction_memory[21] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 22

        // instruction_memory[22] = 8'b01100000; // Opq add // PC = PC + 2 = 24
        // instruction_memory[23] = 8'b00010010; // rA = 1 and rB = 2, final value in rB(2) = 5;

        // instruction_memory[24] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 25
        // instruction_memory[25] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 26
        // instruction_memory[26] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 27
        // instruction_memory[27] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 28

        // instruction_memory[28] = 8'b00000000; // halt instruction

        // //prog4

        //  instruction_memory[0] = 8'b00010000; 

        // instruction_memory[1] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[2] = 8'b11110001; // F, rB = 1;
        // instruction_memory[3] = 8'b00000010; // 1st byte of V = 2, rest all bytes will be zero
        // instruction_memory[4] = 8'b00000000;
        // instruction_memory[5] = 8'b00000000;
        // instruction_memory[6] = 8'b00000000;
        // instruction_memory[7] = 8'b00000000;
        // instruction_memory[8] = 8'b00000000;
        // instruction_memory[9] = 8'b00000000;
        // instruction_memory[10] = 8'b00000000;

        // instruction_memory[11] = 8'b00110000; // irmovq instruction f_valP = f_PC + 10 = 11 
        // instruction_memory[12] = 8'b11110010; // F, rB = 2;
        // instruction_memory[13] = 8'b00000011; // 1st byte of V = 3, rest all bytes will be zero
        // instruction_memory[14] = 8'b00000000;
        // instruction_memory[15] = 8'b00000000;
        // instruction_memory[16] = 8'b00000000;
        // instruction_memory[17] = 8'b00000000;
        // instruction_memory[18] = 8'b00000000;
        // instruction_memory[19] = 8'b00000000;
        // instruction_memory[20] = 8'b00000000;

        // instruction_memory[21] = 8'b01100000; // Opq add // PC = PC + 2 = 23
        // instruction_memory[22] = 8'b00010010; // rA = 1 and rB = 2, final value in rB(4) = 5;

        // instruction_memory[23] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 24
        // instruction_memory[24] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 25
        // instruction_memory[25] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 26
        // instruction_memory[26] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 27
        // instruction_memory[27] = 8'b00010000; // nop instruction f_valP = f_PC + 1 = 28

        // instruction_memory[28] = 8'b00000000; // halt instruction

        // prog 5
        instruction_memory[0]  = 8'b00010000; // nop instruction PC = PC +1 = 1
    instruction_memory[1]  = 8'b01100000; // Opq add
    instruction_memory[2]  = 8'b00000001; // f_rA = 0, f_rB = 1; PC = PC + 2 = 3

    instruction_memory[3]  = 8'b00110000; // irmovq instruction PC = PC + 10 = 13
    instruction_memory[4]  = 8'b11110010; // F, f_rB = 2;
    instruction_memory[5]  = 8'b11111111; // 1st byte of V = 255, rest all bytes will be zero
    instruction_memory[6]  = 8'b00000000; // 2nd byte
    instruction_memory[7]  = 8'b00000000; // 3rd byte
    instruction_memory[8]  = 8'b00000000; // 4th byte
    instruction_memory[9]  = 8'b00000000; // 5th byte
    instruction_memory[10] = 8'b00000000; // 6th byte
    instruction_memory[11] = 8'b00000000; // 7th byte
    instruction_memory[12] = 8'b00000000; // 8th byte (This completes irmovq)

    instruction_memory[13] = 8'b00110000; // irmovq instruction PC = PC + 10 = 23
    instruction_memory[14] = 8'b11110011; // F, f_rB = 3;
    instruction_memory[15] = 8'b00000101; // 1st byte of V = 5, rest all bytes will be zero
    instruction_memory[16] = 8'b00000000; // 2nd byte
    instruction_memory[17] = 8'b00000000; // 3rd byte
    instruction_memory[18] = 8'b00000000; // 4th byte
    instruction_memory[19] = 8'b00000000; // 5th byte
    instruction_memory[20] = 8'b00000000; // 6th byte
    instruction_memory[21] = 8'b00000000; // 7th byte
    instruction_memory[22] = 8'b00000000; // 8th byte (This completes irmovq)

    instruction_memory[23] = 8'b00110000; // irmovq instruction PC = PC + 10 = 33
    instruction_memory[24] = 8'b11110100; // F, f_rB = 4;
    instruction_memory[25] = 8'b00000101; // 1st byte of V = 5, rest all bytes will be zero
    instruction_memory[26] = 8'b00000000; // 2nd byte
    instruction_memory[27] = 8'b00000000; // 3rd byte
    instruction_memory[28] = 8'b00000000; // 4th byte
    instruction_memory[29] = 8'b00000000; // 5th byte
    instruction_memory[30] = 8'b00000000; // 6th byte
    instruction_memory[31] = 8'b00000000; // 7th byte
    instruction_memory[32] = 8'b00000000; // 8th byte (This completes irmovq)

    instruction_memory[33] = 8'b00100000; // rrmovq // PC = PC + 2 = 35
    instruction_memory[34] = 8'b01000101; // f_rA = 4; f_rB = 5; 

    instruction_memory[35] = 8'b01100000; // Opq add // PC = PC + 2 = 37
    instruction_memory[36] = 8'b00110100; // f_rA = 3 and f_rB = 4, final value in f_rB(4) = 10;


    instruction_memory[37] = 8'b01100001; // Opq subq // PC = PC + 2 = 41
    instruction_memory[38] = 8'b00110101; // f_rA = 3, f_rB = 5; both are equal

    instruction_memory[39] = 8'b01110011; //je // PC = PC + 9 = 50
    instruction_memory[40] = 8'b00110100; // Dest = 52; 1st byte
    instruction_memory[41] = 8'b00000000; // 2nd byte                   
    instruction_memory[42] = 8'b00000000; // 3rd byte
    instruction_memory[43] = 8'b00000000; // 4th byte
    instruction_memory[44] = 8'b00000000; // 5th byte
    instruction_memory[45] = 8'b00000000; // 6th byte
    instruction_memory[46] = 8'b00000000; // 7th byte
    instruction_memory[47] = 8'b00000000; // 8th byte

    instruction_memory[48] = 8'b00010000; // nop 
    instruction_memory[49] = 8'b00010000; // nop
    instruction_memory[50] = 8'b00010000; // nop 
    instruction_memory[51] = 8'b00010000; // nop
    instruction_memory[52] = 8'b00010000; // nop 
    instruction_memory[53] = 8'b00010000; // nop
    instruction_memory[54] = 8'b00010000; // nop 
    instruction_memory[55] = 8'b00010000; // nop


    instruction_memory[56] = 8'b01100000; // Opq add
    instruction_memory[57] = 8'b00110101; // f_rA = 3; f_rB = 5;



    instruction_memory[58] = 8'b00000000; // halt

end


always @(*)
begin
    mem_error = 0;
    

    if(f_pc > 100)
    begin
        mem_error=1;
    end


    f_icode = instruction_memory[f_pc][7:4];
    f_ifun = instruction_memory[f_pc][3:0];

    //fetching rA,rB,valC and calculating valP

    if(f_icode == 4'b0000)  // halt
    begin
    halt=1;
    f_valP = f_pc + 64'd1;
    end

    if(f_icode == 4'b0001)  // nop
    begin
    f_valP = f_pc + 64'd1;
    end

    if(f_icode == 4'b0010)  // cmovxx
    begin
    f_rA = instruction_memory[f_pc+1][7:4];
    f_rB = instruction_memory[f_pc+1][3:0];
    f_valP = f_pc + 64'd2;
    end

    if (f_icode == 4'b0011) //irmovq
     begin
     f_rA = instruction_memory[f_pc+1][7:4];
    f_rB = instruction_memory[f_pc+1][3:0];
    f_valC = { instruction_memory[f_pc+9],
             instruction_memory[f_pc+8],
             instruction_memory[f_pc+7],
             instruction_memory[f_pc+6],
             instruction_memory[f_pc+5],
             instruction_memory[f_pc+4],
             instruction_memory[f_pc+3],
             instruction_memory[f_pc+2] };
    f_valP = f_pc + 64'd10;
    end

    if (f_icode == 4'b0100 || f_icode == 4'b0101) //rmmovq or mrmovq
     begin
     f_rA = instruction_memory[f_pc+1][7:4];
    f_rB = instruction_memory[f_pc+1][3:0];
    f_valC = { instruction_memory[f_pc+9],
             instruction_memory[f_pc+8],
             instruction_memory[f_pc+7],
             instruction_memory[f_pc+6],
             instruction_memory[f_pc+5],
             instruction_memory[f_pc+4],
             instruction_memory[f_pc+3],
             instruction_memory[f_pc+2] };
    f_valP = f_pc + 64'd10;
    end


    if(f_icode == 4'b0110)   //OPq
    begin
     f_rA = instruction_memory[f_pc+1][7:4];
    f_rB = instruction_memory[f_pc+1][3:0];
    f_valP = f_pc + 64'd2;
    end


    if (f_icode == 4'b0111 || f_icode == 4'b1000)  // call or jump
    begin
        f_valC = { instruction_memory[f_pc+8],
             instruction_memory[f_pc+7],
             instruction_memory[f_pc+6],
             instruction_memory[f_pc+5],
             instruction_memory[f_pc+4],
             instruction_memory[f_pc+3],
             instruction_memory[f_pc+2],
             instruction_memory[f_pc+1] };

        f_valP = f_pc + 64'd9;
    end

    if (f_icode == 4'b1001) begin
        f_valP = f_pc + 64'd1;
    end

    if (f_icode == 4'b1010 || f_icode == 4'b1011) begin   // pushq or popq
    f_rA = instruction_memory[f_pc+1][7:4];
    f_rB = instruction_memory[f_pc+1][3:0];
    f_valP = f_pc + 64'd2;
    end
end
 
//now we will predict PC
//we dont predict in return

always @(f_valC or f_valP or f_icode)
begin
    
    
    if (f_icode == 4'b0111 || f_icode == 4'b1000) begin
        predicted_PC = f_valC;
    end
    else
    begin
     predicted_PC = f_valP;
    end 
                               
end
endmodule