module LOGIC_UNIT #(parameter IN_DATA_WIDTH = 16, OUT_DATA_WIDTH = 16) 
(
    input wire [IN_DATA_WIDTH-1:0]  A,
    input wire [IN_DATA_WIDTH-1:0]  B,
    input wire                      CLK,
    input wire                      RST,
    input wire                      Logic_Enable,
    input wire [1:0]                Logic_FUN_SEL,
    output reg [OUT_DATA_WIDTH-1:0] Logic_OUT,
    output reg                      Logic_Flag
);

    // internal signals declaration
    reg [OUT_DATA_WIDTH-1:0] Logic_OUT_comb;
    wire Logic_Flag_comb;
    // comb always block for logic operation
    always @(*) begin
        Logic_OUT_comb = 'b0;
        if (Logic_Enable) begin
            case (Logic_FUN_SEL)
                2'b00 :
                begin
                    Logic_OUT_comb = A & B;
                end 
                2'b01 :
                begin
                    Logic_OUT_comb = A | B;
                end
                2'b10 :
                begin
                    Logic_OUT_comb = ~(A & B);
                end
                2'b11 :
                begin
                    Logic_OUT_comb = ~(A | B);
                end
                default: 
                begin
                    Logic_OUT_comb = 'b0;
                end
            endcase
        end
        else begin
           Logic_OUT_comb = 'b0; 
        end
    end
    // comb logic flag
    assign Logic_Flag_comb = (Logic_Enable) ? 1'b1 : 1'b0;
    // sequntial always block for output
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            Logic_OUT <= 'b0;
            Logic_Flag <= 1'b0;
        end
        else begin
            Logic_OUT <= Logic_OUT_comb;
            Logic_Flag <= Logic_Flag_comb;
        end
    end
endmodule