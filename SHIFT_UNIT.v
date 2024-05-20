module SHIFT_UNIT #(parameter IN_DATA_WIDTH = 16, OUT_DATA_WIDTH = 16) 
(
    input wire [IN_DATA_WIDTH-1:0]  A,
    input wire [IN_DATA_WIDTH-1:0]  B,
    input wire                      CLK,
    input wire                      RST,
    input wire                      Shift_Enable,
    input wire [1:0]                Shift_FUN_SEL,
    output reg [OUT_DATA_WIDTH-1:0] Shift_OUT,
    output reg                      Shift_Flag
);

    // internal signals declaration
    reg [OUT_DATA_WIDTH-1:0] Shift_OUT_comb;
    wire Shift_Flag_comb;
    // comb always block for shift operation
    always @(*) begin
        Shift_OUT_comb = 'b0;
        if (Shift_Enable) begin
            case (Shift_FUN_SEL)
                2'b00 :
                begin
                    Shift_OUT_comb = A >> 1;
                end 
                2'b01 :
                begin
                    Shift_OUT_comb = A << 1;
                end
                2'b10 :
                begin
                    Shift_OUT_comb = B >> 1;
                end
                2'b11 :
                begin
                    Shift_OUT_comb = B << 1;
                end
                default: 
                begin
                    Shift_OUT_comb = 'b0;
                end
            endcase
        end
        else begin
           Shift_OUT_comb = 'b0; 
        end
    end
    // comb shift flag
    assign Shift_Flag_comb = (Shift_Enable) ? 1'b1 : 1'b0;
    // sequntial always block for output
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            Shift_OUT <= 'b0;
            Shift_Flag <= 1'b0;
        end
        else begin
            Shift_OUT <= Shift_OUT_comb;
            Shift_Flag <= Shift_Flag_comb;
        end
    end
endmodule