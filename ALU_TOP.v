module ALU_TOP #(parameter TOP_IN_DATA_WIDTH = 16, TOP_OUT_DATA_ARITH_WIDTH = 2*TOP_IN_DATA_WIDTH, TOP_OUT_DATA_WIDTH = TOP_IN_DATA_WIDTH)
(
    input wire signed [TOP_IN_DATA_WIDTH-1:0]         A,
    input wire signed [TOP_IN_DATA_WIDTH-1:0]         B,
    input wire        [3:0]                           ALU_FUN,
    input wire                                        CLK,
    input wire                                        RST,
    output wire signed [TOP_OUT_DATA_ARITH_WIDTH-1:0] Arith_OUT,
    output wire                                       Carry_OUT,
    output wire                                       Arith_Flag,
    output wire        [TOP_OUT_DATA_WIDTH-1:0]       Logic_OUT,
    output wire                                       Logic_Flag,
    output wire        [TOP_OUT_DATA_WIDTH-1:0]       CMP_OUT,
    output wire                                       CMP_Flag,
    output wire        [TOP_OUT_DATA_WIDTH-1:0]       Shift_OUT,
    output wire                                       Shift_Flag
);
    // TOP MODULE internal signals
    wire TOP_Arith_Enable, TOP_Logic_Enable, TOP_CMP_Enable, TOP_Shift_Enable;
    // module instantiations
    DECODER_UNIT  D1 
    (
        .ALU_FUN_SEL(ALU_FUN[3:2]),
        .Arith_Enable(TOP_Arith_Enable),
        .Logic_Enable(TOP_Logic_Enable),
        .CMP_Enable(TOP_CMP_Enable),
        .Shift_Enable(TOP_Shift_Enable)
    );
    ARITHMETIC_UNIT #(.IN_DATA_WIDTH(TOP_IN_DATA_WIDTH), .OUT_DATA_WIDTH(TOP_OUT_DATA_ARITH_WIDTH)) AR1
    (
        .A(A),
        .B(B),
        .CLK(CLK),
        .RST(RST),
        .Arith_Enable(TOP_Arith_Enable),
        .Arith_FUN_SEL(ALU_FUN[1:0]),
        .Arith_OUT(Arith_OUT),
        .Arith_Flag(Arith_Flag),
        .Carry_OUT(Carry_OUT)
    );
    LOGIC_UNIT #(.IN_DATA_WIDTH(TOP_IN_DATA_WIDTH), .OUT_DATA_WIDTH(TOP_OUT_DATA_WIDTH)) L1
    (
        .A(A),
        .B(B),
        .CLK(CLK),
        .RST(RST),
        .Logic_Enable(TOP_Logic_Enable),
        .Logic_FUN_SEL(ALU_FUN[1:0]),
        .Logic_OUT(Logic_OUT),
        .Logic_Flag(Logic_Flag)
    );
    CMP_UNIT #(.IN_DATA_WIDTH(TOP_IN_DATA_WIDTH), .OUT_DATA_WIDTH(TOP_OUT_DATA_WIDTH)) CMP1
    (
        .A(A),
        .B(B),
        .CLK(CLK),
        .RST(RST),
        .CMP_Enable(TOP_CMP_Enable),
        .CMP_FUN_SEL(ALU_FUN[1:0]),
        .CMP_OUT(CMP_OUT),
        .CMP_Flag(CMP_Flag)
    );
    SHIFT_UNIT #(.IN_DATA_WIDTH(TOP_IN_DATA_WIDTH), .OUT_DATA_WIDTH(TOP_OUT_DATA_WIDTH)) SH1 
    (
        .A(A),
        .B(B),
        .CLK(CLK),
        .RST(RST),
        .Shift_Enable(TOP_Shift_Enable),
        .Shift_FUN_SEL(ALU_FUN[1:0]),
        .Shift_OUT(Shift_OUT),
        .Shift_Flag(Shift_Flag)
    );


    
endmodule