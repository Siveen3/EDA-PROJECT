`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:01:53 12/14/2022
// Design Name:   MainModule
// Module Name:   D:/Ain Shams University/Junior/Electronic Design Automation/Project/V2.0/EDA1.0/ATM_tb.v
// Project Name:  EDA1.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MainModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ATM_tb();

	// Inputs
	reg clk;
	reg rst;
    reg Timer;
	reg [3:0] Pin;
	reg [5:0] WithDraw_Amount;
	reg [4:0] Deposit_Amount;
	reg [1:0] Operation;
	reg Card_in;
	reg Language_chosen;
	reg leave;
	//integer numofoperations;
	reg goMain;
	integer i, j, seed, decision, ran;
	// Outputs
	wire [7:0] FinalBalance
	;

	// Instantiate the Unit Under Test (UUT)
	MainModule uut (
		.clk(clk),
        .Timer(Timer),
		.rst(rst), 
		.Pin(Pin),
		.WithDraw_Amount(WithDraw_Amount), 
		.Deposit_Amount(Deposit_Amount), 
		.Operation(Operation), 
		.FinalBalance(FinalBalance),
		.Card_in(Card_in), 
		.Language_chosen(Language_chosen), 
		.leave(leave),
		.goMain(goMain)
	);
	//Clock Generation
	always #12 clk = !clk;
	
	//Assertions
	//else $error("Error, Balance less than zero");
	initial begin
		// Initialize all Inputs by zero
		clk = 0;					//Clock
		rst = 1;					//Reset
		Pin = 0;					//input pin to login
		WithDraw_Amount = 0;		
		Deposit_Amount = 0;
		Operation = 0;				//operation Key: 0 -> withdraw, 1 -> deposit, 2 -> check balance, otherwise -> leaveit
		Card_in = 0;						//To insert card
		Language_chosen = 0;						//To choose language 
		leave = 0;					//To exit
		//numofoperations = 0;		//counter for number of operations
		ran = 0;					//varible to hold random numbers
		goMain = 0;					//to return to the main menu and do another operation
		i = 0;						//counter of iterations
		decision=0;					//random number to decide the decision
		


		#50 rst = 0;
		#50 rst = 1;
	//senario 1
                #25 Card_in = 1; // pin 8alat
                #25 Language_chosen = 1;				
                #25 Pin = 4'b1111;	
                #25 Timer = 0;
                #25 WithDraw_Amount = $urandom()% 500; 
                #25 Deposit_Amount= $urandom()% 500; 
                #25 Operation = $urandom()% 4;
                #25 leave = $urandom()% 2;
                #25 goMain = $urandom()% 2;
                @(negedge clk);
                if (Pin != 4'b1101)
                $display("error incorrect PIN");
                else
                $display("Correct PIN");

                // senario 2    invalid operation
                #25 Card_in = 1;				//default Card_in
                #25 Language_chosen = 1;				//default Language_chosen
                #25 Pin = 4'b1101;	
                #25 Timer = 0;
                #25 WithDraw_Amount = $urandom()% 500; 
                #25 Deposit_Amount= $urandom()% 500; // 4/30 probability to randomize the pin
                #25 Operation = 2'b11;
                #25 leave = $urandom()% 2;
                #25 goMain = $urandom()% 2;
                @(negedge clk);
                if (Operation == 2'b11)
                $display("error ejecting");
// senario3 check incorrect PIN
                #25 Card_in = 1;				//default Card_in
                #25Language_chosen = 1;				//default Language_chosen	
                #25Timer = 0;
                #25rst = 1;
                #25WithDraw_Amount = $urandom()% 500; 
                #25Deposit_Amount= $urandom()% 500; // 
                #25 Operation = $urandom()% 3;
                #25 leave = $urandom()% 2;
               
                #25 goMain = $urandom()% 2;
                for(i=0;i<100;i=i+1)
                #25 Pin= 2+ $urandom()%8;
               // senario Time 
                 #25 Card_in = 1;				//default Card_in
                 #25 Language_chosen = 0;				//default Language_chosen	
                 #25 Timer = 1;
                 #25 rst = 1;
                 #25 WithDraw_Amount = $urandom()% 500; 
                 #25 Deposit_Amount= $urandom()% 500; //
                 #25 Operation =$urandom(seed)%4; 
                 #25 leave = $urandom()% 2;
                
                 #25 goMain = $urandom()% 2;
                 #25 Pin= 4'b1101;
                @(negedge clk);
                if(1)
                $display("sorry we ran out of time");
                

   // randimized testings
    for(j=0 ; j<70 ; j=j+1)
			begin
			
				seed =j;
            for(i=0;i<1000;i=i+1)
            begin
                @(negedge clk);
                 #25Card_in = 1;				//default Card_in
                 #25Language_chosen = $urandom(seed)% 2;				//default Language_chosen
                 #25Pin = 4'b1101;
                #25ran = $urandom(seed)%30;
                if(ran>20)
                #25Pin= $urandom(seed)% 16;	
                #25Timer = 0;
                #25rst = 1;
                #25WithDraw_Amount = $random(seed)% 500; 
                #25Deposit_Amount= $random(seed)% 500; 
                #25Operation = $urandom(seed)% 5;
                #25leave = $urandom(seed)% 2;
                #25goMain = $urandom(seed)% 2;


            end end
		
		$stop;
	 end




endmodule // display assertions