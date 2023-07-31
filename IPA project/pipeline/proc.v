`include "fetch.v"
`include "fetchreg.v"
`include "decode.v"
`include "decodereg.v"
`include "execute.v"
`include "executereg.v"
`include "memory.v"
`include "memoryreg.v"
`include "writeback.v"
`include "writebackreg.v"
`include "select_PC.v"
`include "controllogic.v"

module processor();

reg clk;
reg [64:1] f_pc;

wire [64:1] f_valP, f_valC;
wire [4:1] f_icode, f_ifun, f_rA, f_rB;

wire [64:1] F_predicted_PC, predicted_PC;
wire [64:1] next_PC;
wire valid_inst, mem_error, halt;


wire [4:1] D_icode, D_ifun, D_rA, D_rB;
wire [4:1] d_dstE, d_dstM, d_srcA, d_srcB, d_icode, d_ifun;
wire [64:1] D_valC, D_valP, d_valC;
wire [64:1] d_valA, d_valB;


wire [64:1] e_valE;
wire [4:1] e_dstE;
wire [4:1] e_icode, e_dstM;
wire [64:1] e_valA;
wire [4:1] E_icode, E_ifun, E_srcA, E_srcB, E_dstE, E_dstM;
wire [64:1] E_valA, E_valB, E_valC;
wire e_cnd, ZF, SF, OF;

wire [64:1] M_valA, M_valE;
wire [4:1] M_icode, M_dstE, M_dstM;
wire [4:1]  m_dstE, m_dstM, m_icode;
wire [64:1] m_valE;
wire M_cnd;
wire [64:1] m_valM;

wire [64:1] W_valM, W_valE;
wire [4:1] W_icode, W_dstM, W_dstE;

wire F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall;

reg [64:1] reg_file [0:14];
wire [64:1] reg_wire [0:14];

fetchreg FR1(clk, predicted_PC, F_predicted_PC,F_stall);

decodereg DR1(clk,D_bubble,D_stall, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);

executereg ER1(clk,E_bubble, d_icode, d_ifun, d_valA, d_valB, d_valC, d_srcA, d_srcB, d_dstE, d_dstM, E_icode, E_ifun, E_valA, E_valB, E_valC, E_srcA, E_srcB, E_dstE, E_dstM);

memoryreg MR1(clk,M_bubble, e_cnd, e_icode, e_valA, e_valE, e_dstE, e_dstM,  M_cnd, M_icode, M_valE, M_valA, M_dstE, M_dstM);

writebackreg WR1(clk,W_stall, m_icode, m_valE, m_valM, m_dstE, m_dstM, W_icode, W_valE, W_valM, W_dstE, W_dstM);


fetch F1(clk, f_pc, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, predicted_PC, mem_error, halt,valid_inst);

select_PC sp1(clk,F_predicted_PC , M_valA , M_icode, W_valM ,W_icode, M_cnd , next_PC);

decode D1(clk, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP,
        e_dstE, e_dstM, e_valE, M_dstE, M_valE, M_dstM, m_valM, W_dstM, W_valM, W_dstE, W_valE,
        reg_file[0], reg_file[1], reg_file[2], reg_file[3], reg_file[4], reg_file[5], reg_file[6], reg_file[7],
        reg_file[8], reg_file[9], reg_file[10], reg_file[11], reg_file[12], reg_file[13], reg_file[14],
        d_dstE, d_dstM, d_srcA, d_srcB, d_valA, d_valB, d_valC, d_icode, d_ifun);

execute E1(clk, E_icode, E_ifun, E_valA, E_valB, E_valC, e_valE, e_dstE,e_dstM, E_dstE,E_dstM, e_cnd, ZF, SF, OF, e_icode, e_valA, e_dstM);

memory M1(clk, M_icode, M_valA, M_valE, M_dstE, M_dstM, m_icode, m_dstE, m_dstM, m_valM, m_valE);

writeback WB1(clk, W_icode, W_valE, W_valM, W_dstE, W_dstM, 
            reg_wire[0], reg_wire[1], reg_wire[2], reg_wire[3], reg_wire[4], reg_wire[5], reg_wire[6], reg_wire[7], 
            reg_wire[8], reg_wire[9], reg_wire[10], reg_wire[11], reg_wire[12], reg_wire[13], reg_wire[14]);
controllogic CL1(F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall,
                    D_icode,d_srcA,d_srcB,E_icode,E_dstM,e_cnd,M_icode);

initial begin
    // $dumpfile("pipe_processor.vcd");
    // $dumpvars(0, processor);

    clk = 1;
    f_pc = 64'd0;

    $monitor(" wdst = %d ,w_valE=%d,Eifun=%d,EvalA=%d,EvLb=%D,e_vale = %0d,e_cnd =%d,D_stall =%0d,D_bubble =%0d,e_cnd=%0d,W_dstE=%0d fstall=%0d  , %0d  , %0d  ,f_pc=%0d, f_icode=%0d, f_ifun=%0d, f_rA=%0d, f_rB=%0d, f_valP=%0d, f_valC=%0d, D_icode=%0d DrA = %0d Drb = %0d , d_valA=%0d ,d_valB=%0d , E_icode=%0d, M_icode=%0d, W_icode=%0d, mem_err=%0d, halt=%0d,0=%0d ,  1=%0d, 2=%0d, 3=%0d, 4=%0d, 5=%0d, 6=%0d, 7=%0d, 8=%0d, 9=%0d, 10=%0d, 11=%0d, 12=%0d, 13=%0d, 14=%0d", 
             W_dstE,W_valE,E_ifun,e_valA,E_valB,e_valE,e_cnd,D_stall,D_bubble,e_cnd,W_dstE,F_stall,predicted_PC,F_predicted_PC ,f_pc, f_icode, f_ifun, f_rA, f_rB, f_valP, f_valC, D_icode,D_rA,D_rB,d_valA,d_valB, e_icode, M_icode, W_icode, mem_error, halt, 
             reg_file[0],reg_file[1], reg_file[2], reg_file[3], reg_file[4], reg_file[5], reg_file[6], reg_file[7], reg_file[8],
            reg_file[9], reg_file[10], reg_file[11], reg_file[12], reg_file[13], reg_file[14]);
end


always    #5 clk = ~clk;
   
always@(*)
    begin
        if(halt == 1)
            $finish;
    end

always @(*)
    begin
        f_pc <= next_PC;
    end

always @(*)
    begin
        reg_file[0] = reg_wire[0];
        reg_file[1] = reg_wire[1];
        reg_file[2] = reg_wire[2];
        reg_file[3] = reg_wire[3];
        reg_file[4] = reg_wire[4];
        reg_file[5] = reg_wire[5];
        reg_file[6] = reg_wire[6];
        reg_file[7] = reg_wire[7];
        reg_file[8] = reg_wire[8];
        reg_file[9] = reg_wire[9];
        reg_file[10] = reg_wire[10];
        reg_file[11] = reg_wire[11];
        reg_file[12] = reg_wire[12];
        reg_file[13] = reg_wire[13];
        reg_file[14] = reg_wire[14];
        
    end

endmodule

