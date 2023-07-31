module controllogic(F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall,
                    D_icode,d_srcA,d_srcB,E_icode,E_dstM,e_cnd,M_icode);
    input [3:0] D_icode,E_icode,M_icode;
    input [3:0] d_srcA,d_srcB,E_dstM;
    input e_cnd;

    output reg F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall;


    always @(*)
    begin
        F_stall = 0;
        D_stall = 0;
        D_bubble = 0;
        E_bubble = 0;
        M_bubble = 0;
         W_stall = 0;
      
        if(E_icode==4'h7 & !e_cnd)
        begin
            D_bubble = 1;
            E_bubble = 1;
        end
        else if((E_icode == 4'h5 | E_icode == 4'hB) & (E_dstM==d_srcA | E_dstM==d_srcB))
        begin
            F_stall = 1;
            D_stall = 1;
            E_bubble = 1;
        end
        else if(E_icode == 4'h9 | M_icode == 4'h9 | D_icode == 4'h9)
        begin
            F_stall = 1;
            D_bubble = 1;
        end
        
    end
endmodule