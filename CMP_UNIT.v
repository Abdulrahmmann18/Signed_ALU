module CMP_UNIT #(parameter IN_DATA_WIDTH = 16, OUT_DATA_WIDTH = 16) 
(
    input wire [IN_DATA_WIDTH-1:0]  A,
    input wire [IN_DATA_WIDTH-1:0]  B,
    input wire                      CLK,
    input wire                      RST,
    input wire                      CMP_Enable,
    input wire [1:0]                CMP_FUN_SEL,
    output reg [OUT_DATA_WIDTH-1:0] CMP_OUT,
    output reg                      CMP_Flag
);

    // internal signals declaration
    reg [OUT_DATA_WIDTH-1:0] CMP_OUT_comb;
    wire CMP_Flag_comb;
    // comb always block for CMP operation
    always @(*) begin
        CMP_OUT_comb = 'b0;
        if (CMP_Enable) begin
            case (CMP_FUN_SEL)
                2'b00 :
                begin
                    CMP_OUT_comb = 'b0;
                end 
                2'b01 :
                begin
                    CMP_OUT_comb = (A == B) ? 'b1 : 'b0;
                end
                2'b10 :
                begin
                    CMP_OUT_comb = (A > B) ? 'b10 : 'b0;
                end
                2'b11 :
                begin
                    CMP_OUT_comb = (A < B) ? 'b11 : 'b0;
                end
                default: 
                begin
                    CMP_OUT_comb = 'b0;
                end
            endcase
        end
        else begin
           CMP_OUT_comb = 'b0; 
        end
    end
    // comb CMP flag
    assign CMP_Flag_comb = (CMP_Enable) ? 1'b1 : 1'b0;
    // sequntial always block for output
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            CMP_OUT <= 'b0;
            CMP_Flag <= 1'b0;
        end
        else begin
            CMP_OUT <= CMP_OUT_comb;
            CMP_Flag <= CMP_Flag_comb;
        end
    end
endmodule