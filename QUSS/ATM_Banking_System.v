`timescale 1ns / 1ps
module MainModule(
    input clk,
    input Timer,
	input rst,
    input [3:0] Pin,
	input [5:0] WithDraw_Amount,
	input [4:0] Deposit_Amount,
	input [1:0] Operation,
	output reg[7:0] FinalBalance, // output fe balance state
    output reg ATM_Usage_Finished, Deposited_Successfully, Withdrew_Successfully,
    output reg[1:0] Count,// 2 bits take tcare
	input Card_in , Language_chosen ,leave, goMain	 //InsertCard,LanguageChosen,Exit
    );
reg [3:0] pin_number = 4'b1101;	 //default password
reg [7:0] balance = 8'd50;
reg [3:0] next_state;
reg [3:0] current_state;
reg [1:0] Counter = 2'b00;
reg [1:0] op;
reg	Valid_Pin= 1'b0,B_check= 1'b0, Entered_Amount =1'b0; //ValidPass,BalanceCheck,EnteredAmount, goMain

parameter  IDLE = 4'b000,
			Language  = 4'b0001,
			PIN_state  = 4'b0010,
			Home_state  = 4'b0011,
			Withdraw_state  = 4'b0100,
			Deposit_state  = 4'b0101,
			Balance_state  = 4'b0110,
			Check_Balance_state  = 4'b0111,
			Confirm_deposit_state  = 4'b1000,
			confirm_withdraw_state  = 4'b1001,
			eject_card_state = 4'b1111;
always @( posedge clk or negedge rst or posedge Timer)
	begin
		if (~rst)
			begin
				current_state <=eject_card_state;
			end
        else if(Timer)
                current_state <=eject_card_state;
		else	current_state <= next_state;
	end
	
//// psl assert always ((Operation > 4) next ->  ATM_Usage_Finished== 1) @(posedge clk);	
////psl assert always(balance >=0) @(posedge clk);
////psl assert never(next_state == Deposit_state && op != 2'b01) @(posedge clk);
////psl assert never(next_state == Confirm_deposit_state && current_state == Deposit_state && Entered_Amount == 0) @(posedge clk);
////psl assert never(next_state == confirm_withdraw_state && current_state == Check_Balance_state && B_check == 0) @(posedge clk);
////psl assert never(next_state == Home_state && current_state == PIN_state && Valid_Pin == 0) @(posedge clk);

		
always@(*)
	begin
		
		case (current_state)
			IDLE:	if(Card_in) next_state = Language;
					else next_state = IDLE;
	
			Language: if(Language_chosen) next_state = PIN_state;
				    else next_state = Language;
			
			PIN_state: 
				begin
					if(leave)next_state =eject_card_state;
					else next_state = PIN_state;
					if(Pin==pin_number) Valid_Pin = 1'b1;
					else Valid_Pin = 1'b0;
					if(Valid_Pin) 
						begin 
						next_state = Home_state; 				
						end
					else 
						begin
							Counter = Counter + 1'b1;
							next_state = PIN_state; //added to be checked
							if(Counter == 2'b11)
								next_state =eject_card_state;
						end
				end
			Home_state:					    
				begin
					op = Operation; //in verfCard_ination force user to exit as we dont have time
					if(op == 2'b00) next_state = Withdraw_state;
					else if(op == 2'b01) next_state = Deposit_state;
					else if(op == 2'b10) next_state = Balance_state;
					else next_state =eject_card_state;
				end
				
			Withdraw_state:
				begin
					if(goMain)next_state = Home_state;
					else 
					begin
						if(WithDraw_Amount > 0) Entered_Amount = 1'b1; 
						else Entered_Amount = 1'b0;
						if(Entered_Amount) next_state = Check_Balance_state;
						else next_state = Withdraw_state;
					end 
				end
			
			Deposit_state:
				begin
					if(Deposit_Amount > 0) Entered_Amount = 1'b1; 
					else Entered_Amount = 1'b0;
					if(Entered_Amount)next_state = Confirm_deposit_state;
					else next_state = Deposit_state;
				end
				
			Balance_state://n8yrha
				begin
					//FinalBalance = balance;
					next_state = Home_state;
				end
			Check_Balance_state:
				begin
					if(WithDraw_Amount <= balance) B_check = 1'b1;
					else B_check = 1'b0;
					if(B_check) next_state = confirm_withdraw_state;
					else next_state = Withdraw_state;
				end
			Confirm_deposit_state: 
				begin
					balance = balance + Deposit_Amount;
					next_state = Home_state;
				end
			confirm_withdraw_state:
				begin
					balance = balance - WithDraw_Amount;
					next_state = Home_state; //TO BE SET TO Home_state
				end
			eject_card_state:
				begin
					next_state = IDLE;
					Valid_Pin = 1'b0; B_check= 1'b0; Entered_Amount =1'b0; 
					Counter = 2'b00;
					balance = 50;
					FinalBalance = 8'b0;
				end
			default:
				begin
					next_state =eject_card_state;
					FinalBalance = 8'b0;
				end
		endcase
	end
//Output combinational logic
    always @(*)
    begin
    case(current_state)
    
        IDLE:   begin
            ATM_Usage_Finished        = 1'b0;
        end
        
        PIN_state:   begin
            Count= Counter;

        end
        Balance_state:      begin
                                FinalBalance = balance;
                            end

        Confirm_deposit_state: begin
            Deposited_Successfully =  1'b1;

        end
        confirm_withdraw_state: begin
             Withdrew_Successfully =  1'b1;
        end        
        eject_card_state:   begin
            ATM_Usage_Finished        = 1'b1;
                            end                    

        
    endcase
    end


endmodule
