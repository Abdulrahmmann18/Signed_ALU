module ARITHMETIC_UNIT #(parameter IN_DATA_WIDTH = 16, OUT_DATA_WIDTH = 2*IN_DATA_WIDTH) 
(
    input wire signed [IN_DATA_WIDTH-1:0]  A,
    input wire signed [IN_DATA_WIDTH-1:0]  B,
    input wire                             CLK,
    input wire                             RST,
    input wire                             Arith_Enable,
    input wire        [1:0]                Arith_FUN_SEL,
    output reg signed [OUT_DATA_WIDTH-1:0] Arith_OUT,
    output reg                             Arith_Flag,
    output reg                             Carry_OUT
);

    // internal signals declaration
    reg [OUT_DATA_WIDTH-1:0] Arith_OUT_comb;
    wire Arith_Flag_comb;
    reg Carry_OUT_comb;
    // comb always block for shift operation
    always @(*) begin
        Arith_OUT_comb = 'b0;
        Carry_OUT_comb = 1'b0;
        if (Arith_Enable) begin
            case (Arith_FUN_SEL)
                2'b00 :
                begin
                    Arith_OUT_comb = A + B;
                    Carry_OUT_comb = Arith_OUT_comb[IN_DATA_WIDTH];
                end 
                2'b01 :
                begin
                    Arith_OUT_comb = A - B;
                    Carry_OUT_comb = Arith_OUT_comb[IN_DATA_WIDTH];
                end
                2'b10 :
                begin
                    Arith_OUT_comb = A * B;
                end
                2'b11 :
                begin
                    Arith_OUT_comb = A / B;
                end
                default: 
                begin
                    Arith_OUT_comb = 'b0;
                    Carry_OUT_comb = 1'b0;
                end
            endcase
        end
        else begin
            Arith_OUT_comb = 'b0;
            Carry_OUT_comb = 1'b0; 
        end
    end
    // comb Arith flag
    assign Arith_Flag_comb = (Arith_Enable) ? 1'b1 : 1'b0;
    // sequntial always block for output
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            Arith_OUT <= 'b0;
            Arith_Flag <= 1'b0;
            Carry_OUT <= 1'b0;
        end
        else begin
            Arith_OUT <= Arith_OUT_comb;
            Arith_Flag <= Arith_Flag_comb;
            Carry_OUT <= Carry_OUT_comb;
        end
    end
endmodule