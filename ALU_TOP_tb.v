`timescale 1us/1ns
module ALU_TOP_tb();
	
	parameter TOP_IN_DATA_WIDTH = 16;
	parameter TOP_OUT_DATA_ARITH_WIDTH = 2*TOP_IN_DATA_WIDTH;
    parameter TOP_OUT_DATA_WIDTH = TOP_IN_DATA_WIDTH;
	// signal declaration
	reg signed  [TOP_IN_DATA_WIDTH-1:0]        A_tb, B_tb;
	reg         [3:0]                          ALU_FUN_tb;
	reg								           CLK, RST;
	wire signed [TOP_OUT_DATA_ARITH_WIDTH-1:0] Arith_OUT_tb;
    wire                           		       Carry_OUT_tb;
    wire                          		       Arith_Flag_tb;
    wire 	    [TOP_OUT_DATA_WIDTH-1:0]       Logic_OUT_tb;
    wire       		                           Logic_Flag_tb;
    wire 	    [TOP_OUT_DATA_WIDTH-1:0]       CMP_OUT_tb;
    wire      	      	                       CMP_Flag_tb;
    wire 	    [TOP_OUT_DATA_WIDTH-1:0]       Shift_OUT_tb;
    wire       		                           Shift_Flag_tb;
    // internal signals
    wire [3:0] flags; 
    assign flags = {Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, Shift_Flag_tb};
    // DUT Instantiation
    ALU_TOP ALU1
    (
    	.A(A_tb), .B(B_tb),
    	.ALU_FUN(ALU_FUN_tb), .CLK(CLK), .RST(RST),
    	.Arith_OUT(Arith_OUT_tb), .Carry_OUT(Carry_OUT_tb), .Arith_Flag(Arith_Flag_tb),
    	.Logic_OUT(Logic_OUT_tb), .Logic_Flag(Logic_Flag_tb),
    	.CMP_OUT(CMP_OUT_tb), .CMP_Flag(CMP_Flag_tb),
    	.Shift_OUT(Shift_OUT_tb), .Shift_Flag(Shift_Flag_tb)
    );
    // clk generation block
    always begin
    	#4 CLK = ~CLK;
    	#6 CLK = ~CLK;
    end
    // test stimulus
    initial begin
    	// initialize
    	CLK = 0;  RST = 0;  A_tb = +'d10;  B_tb = +'d20;  ALU_FUN_tb = 4'b0000;
    	#10
    	// addition
    	// case(1) (+ve) + (+ve)
    	RST = 1;
    	#10

        $display ("*********************Arithmetic Operations*********************");

    	$display ("test case 1");
    	if ((Arith_OUT_tb == +'d30) && (flags == 4'b1000)) 
    		$display("addition of %0d + %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
    	else
    		$display("addition of %0d + %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);

    	// case(2) (+ve) + (-ve)
    	A_tb = +'d10;  B_tb = -'d20;
        #10
    	$display ("test case 2");
    	if ((Arith_OUT_tb == -'d10) && (flags == 4'b1000)) 
    		$display("addition of %0d + %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
    	else
    		$display("addition of %0d + %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
    
    	// case(3) (-ve) + (-ve)
    	A_tb = -'d10;  B_tb = +'d20;
        #10
    	$display ("test case 3");
    	if ((Arith_OUT_tb == +'d10) && (flags == 4'b1000)) 
    		$display("addition of %0d + %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
    	else
    		$display("addition of %0d + %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
    	
    	// case(4) (-ve) + (-ve)
    	A_tb = -'d10;  B_tb = -'d20;
        #10
    	$display ("test case 4");
    	if ((Arith_OUT_tb == -'d30) && (flags == 4'b1000)) 
    		$display("addition of %0d + %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
    	else
    		$display("addition of %0d + %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
    	
        // subtraction
        // case(5) (+ve) - (+ve)
        A_tb = +'d10;  B_tb = +'d20;  ALU_FUN_tb = 4'b0001;
        #10
        $display ("test case 5");
        if ((Arith_OUT_tb == -'d10) && (flags == 4'b1000)) 
            $display("subtraction of %0d - %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("subtraction of %0d - %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(6) (+ve) - (-ve)
        A_tb = +'d10;  B_tb = -'d20;
        #10
        $display ("test case 6");
        if ((Arith_OUT_tb == +'d30) && (flags == 4'b1000)) 
            $display("subtraction of %0d - %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("subtraction of %0d - %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(7) (-ve) - (-ve)
        A_tb = -'d10;  B_tb = +'d20;
        #10
        $display ("test case 7");
        if ((Arith_OUT_tb == -'d30) && (flags == 4'b1000)) 
            $display("subtraction of %0d - %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("subtraction of %0d - %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(8) (-ve) - (-ve)
        A_tb = -'d10;  B_tb = -'d20;
        #10
        $display ("test case 8");
        if ((Arith_OUT_tb == +'d10) && (flags == 4'b1000)) 
            $display("subtraction of %0d - %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("subtraction of %0d - %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);

        // Multplication
        // case(9) (+ve) * (+ve)
        A_tb = +'d10;  B_tb = +'d20;  ALU_FUN_tb = 4'b0010;
        #10
        $display ("test case 9");
        if ((Arith_OUT_tb == +'d200) && (flags == 4'b1000)) 
            $display("Multplication of %0d * %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Multplication of %0d * %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(10) (+ve) * (-ve)
        A_tb = +'d10;  B_tb = -'d20;
        #10
        $display ("test case 10");
        if ((Arith_OUT_tb == -'d200) && (flags == 4'b1000)) 
            $display("Multplication of %0d * %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Multplication of %0d * %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(11) (-ve) * (-ve)
        A_tb = -'d10;  B_tb = +'d20;
        #10
        $display ("test case 11");
        if ((Arith_OUT_tb == -'d200) && (flags == 4'b1000)) 
            $display("Multplication of %0d * %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Multplication of %0d * %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(12) (-ve) * (-ve)
        A_tb = -'d10;  B_tb = -'d20;
        #10
        $display ("test case 12");
        if ((Arith_OUT_tb == +'d200) && (flags == 4'b1000)) 
            $display("Multplication of %0d * %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Multplication of %0d * %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);

        // Division
        // case(13) (+ve) / (+ve)
        A_tb = +'d20;  B_tb = +'d10;  ALU_FUN_tb = 4'b0011;
        #10
        $display ("test case 13");
        if ((Arith_OUT_tb == +'d2) && (flags == 4'b1000)) 
            $display("Division of %0d / %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Division of %0d / %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(14) (+ve) / (-ve)
        A_tb = +'d20;  B_tb = -'d10;
        #10
        $display ("test case 14");
        if ((Arith_OUT_tb == -'d2) && (flags == 4'b1000)) 
            $display("Division of %0d / %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Division of %0d / %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(15) (-ve) / (-ve)
        A_tb = -'d20;  B_tb = +'d10;
        #10
        $display ("test case 15");
        if ((Arith_OUT_tb == -'d2) && (flags == 4'b1000)) 
            $display("Division of %0d / %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Division of %0d / %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(16) (-ve) / (-ve)
        A_tb = -'d20;  B_tb = -'d10;
        #10
        $display ("test case 16");
        if ((Arith_OUT_tb == +'d2) && (flags == 4'b1000)) 
            $display("Division of %0d / %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("Division of %0d / %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        // AND 
        $display ("*********************Logic Operations*********************");
        // case(17) (+ve) & (+ve)
        A_tb = +'d20;  B_tb = +'d10;  ALU_FUN_tb = 4'b0100;
        #10
        $display ("test case 17");
        if ((Logic_OUT_tb == +'d0) && (flags == 4'b0100)) 
            $display("AND Operation of %0d & %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("AND Operation of %0d & %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);

        // case(18) (+ve) | (+ve)
        A_tb = +'d20;  B_tb = +'d10;  ALU_FUN_tb = 4'b0101;
        #10
        $display ("test case 18");
        if ((Logic_OUT_tb == +'d30) && (flags == 4'b0100)) 
            $display("OR Operation of %0d | %0d = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("OR Operation of %0d | %0d = %0d is failled", A_tb, B_tb, Arith_OUT_tb);

        // case(19) (+ve) NAND (+ve)
        A_tb = +'d20;  B_tb = +'d10;  ALU_FUN_tb = 4'b0110;
        #10
        $display ("test case 19");
        if ((Logic_OUT_tb == +'hffff) && (flags == 4'b0100)) 
            $display("NAND Operation of ~(%0d & %0d) = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("NAND Operation of ~(%0d & %0d) = %0d is failled", A_tb, B_tb, Arith_OUT_tb);
        
        // case(20) (+ve) NOR (+ve)
        A_tb = +'d20;  B_tb = +'d10;  ALU_FUN_tb = 4'b0111;
        #10
        $display ("test case 20");
        if ((Logic_OUT_tb == +'hffe1) && (flags == 4'b0100)) 
            $display("NOR Operation of ~(%0d | %0d) = %0d is passed", A_tb, B_tb, Arith_OUT_tb);
        else
            $display("NOR Operation of ~(%0d | %0d) = %0d is failled", A_tb, B_tb, Arith_OUT_tb);

        $display ("*********************CMP Operations*********************");

        // case(21)
        A_tb = +'d20;  B_tb = +'d20;  ALU_FUN_tb = 4'b1001;
        #10
        $display ("test case 21");
        if ((CMP_OUT_tb == +'d1) && (flags == 4'b0010)) 
            $display("equal Operation is passed");
        else
            $display("equal Operation is failled");

        // case(22)
        A_tb = +'d20;  B_tb = +'d10;  ALU_FUN_tb = 4'b1010;
        #10
        $display ("test case 22");
        if ((CMP_OUT_tb == +'d2) && (flags == 4'b0010)) 
            $display("greater than Operation is passed");
        else
            $display("greater than Operation is failled");

        // case(23)
        A_tb = +'d10;  B_tb = +'d20;  ALU_FUN_tb = 4'b1011;
        #10
        $display ("test case 23");
        if ((CMP_OUT_tb == +'d3) && (flags == 4'b0010)) 
            $display("less than Operation is passed");
        else
            $display("less than Operation is failled");

        $display ("*********************shift Operations*********************");
        
        // case(24)
        A_tb = +'d1;  B_tb = +'d10;  ALU_FUN_tb = 4'b1100;
        #10
        $display ("test case 24");
        if ((Shift_OUT_tb == +'d0) && (flags == 4'b0001)) 
            $display("shift right A Operation is passed");
        else
            $display("shift right A Operation is failled");

        
        // case(25)
        A_tb = +'d1;  B_tb = +'d10;  ALU_FUN_tb = 4'b1101;
        #10
        $display ("test case 25");
        if ((Shift_OUT_tb == +'d2) && (flags == 4'b0001)) 
            $display("shift left A Operation is passed");
        else
            $display("shift left A Operation is failled");

    
        // case(26)
        A_tb = +'d1;  B_tb = +'d1;  ALU_FUN_tb = 4'b1110;
        #10
        $display ("test case 26");
        if ((Shift_OUT_tb == +'d0) && (flags == 4'b0001)) 
            $display("shift right B Operation is passed");
        else
            $display("shift right B Operation is failled");

        // case(27)
        A_tb = +'d1;  B_tb = +'d1;  ALU_FUN_tb = 4'b1111;
        #10
        $display ("test case 27");
        if ((Shift_OUT_tb == +'d2) && (flags == 4'b0001)) 
            $display("shift left B Operation is passed");
        else
            $display("shift left B Operation is failled");

        $display ("**************** NOP ****************");
        // case(28)
        A_tb = +'d1;  B_tb = +'d1;  ALU_FUN_tb = 4'b1000;
        #10
        if ((CMP_OUT_tb == +'d0) && (flags == 4'b0010)) 
            $display("NOP is passed");
        else
            $display("NOP is failled");
        
        #10;
    	$stop; 
    end
endmodule
