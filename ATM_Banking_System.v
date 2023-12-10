// Timer - how to handle it ..c++
// lazem files?? HARDCODED :0
// How to know which account is currently running even though we just insert the visa_password
// C++
// lw hardcoded, 2D Arrays or objects?
// how to link?





//--------------------------------------
// CONFIRM withdraw (check)
// CONFIRM transfer (check)
// CONFIRM deposit
// CONFIRM balance
// 3 chances in Transfer
//VIP 2ZBOTY EL BITS M3 EL ARRAY 3SHAN USER INPUTS+ eject 25er kol state

module ATM (
input clk, rst, Card_in, Language, Timer, money_counting,// hi
input[2:0] opcode,
input[13:0] password, new_pin,
input allowwithdraw,take_receipt,allow_transfer,
input wire  [15:0] Pers_Account_No, ur_account,
input wire  [31:0] withdraw_amount,Transfer_Amount,
output reg Transfer_Done, ATM_Usage_Finished, Balance_Shown, Deposited_Successfully, Withdrawed_Successfully
// don't forget to add your outputs 7ader 7ader2
);
integer i;
wire [13:0] ur_pin,ur_balance;
reg[3:0] current_state, next_state;
reg[1:0] chances_Pin = 2'b00;
reg[1:0] chances_Taccount = 2'b00;
reg[1:0] chances_ur_account = 2'b00;
reg [15:0] account [0:3][0:2] =
{{16'hC582, 16'h1F8E, 16'h1388}, // no, pin,balance
{16'h706C, 16'h04C7, 16'h1F40},
{16'h3219, 16'h04D2, 16'h1D4C},
{16'h86B9, 16'h0D05, 16'h0BB8}};

parameter[4:0]  idle_state                  = 5'b00000,
                insert_card_state           = 5'b00001,
                language_state              = 5'b00010,
                pin_state                   = 5'b00011,
                home_state                  = 5'b00100,
                balance_state               = 5'b00101,
                withdraw_state              = 5'b00110,//1
                check_withdraw_state        = 5'b00111, //2
                confirm_withdraw_state      = 5'b01000,     //3
                deposit_state               = 5'b01001,//1
                confirm_deposit_state       = 5'b01010,          //2
                transfer_state              = 5'b01011,//1
                confirm_account_state       = 5'b01100,       //2
                check_transfer_value_state  = 5'b01101, //3
                confirm_transfer_state      = 5'b01110, //4
                print_state                 = 5'b01111,
                eject_card_state            = 5'b10000,
                one_more_transaction        = 5'b10001,//
                change_pin_state            = 5'b10010;

					
					 

//State register logic
    always@(posedge clk or posedge reset) begin
        if(reset)
            current_state <= insert_card_state;
        else
            current_state <= next_state; 
    end



//Next State combinational logic
    always @(*)
    begin
    case(current_state)
    Idle     		: begin
                        if(Card_in == 1'b1)
                            next_state = insert_card_state ;
                        else
                            next_state = Idle ;			  
                    end
	insert_card_state   :begin  
                                if(chances_ur_account  == 2'b11)
                                  next_state = eject_card_state;
				                  else begin
								      for(i=0;i<3;i=i+1)begin
                                      if(account[i][0]== ur_account) begin
                                        ur_balance=account[i][2];
                                        ur_pin = account[i][1];
                                         next_state= language_state;
                                    end
                                      end
                                    else begin
                                      chances_ur_account = chances_ur_account +1;
                                      next_state = confirm_account_state;
                                      end
                                      end			  
								end
				 
        
    language_state : begin
                        next_state = pin_state;		  
                    end

    pin_state       : begin
                        if(chances_Pin == 2'b11)
                        next_state = eject_card_state;
				        else if(password != ur_pin) begin
                            chances = chances + 1;
					        next_state = pin_state;
                        end
    end
    
    home_state      : begin
                        if(opcode == 3'b000)
                            next_state = eject_card_state;
                        else if(opcode == 3'b001)
                            next_state = balance_state;
                        else if(opcode == 3'b010)
                            next_state = withdraw_state;
                        else if(opcode == 3'b011)
                            next_state = deposit_state;
                        else if(opcode == 3'b100)
                            next_state = transfer_state;//
                        else if(opcode == 3'b101)
                            next_state = change_pin_state;
                    end
    withdraw_state     		: begin
								next_state = allow_withdraw_state;	//	value by5osh	  
								end
    allow_withdraw_state    :begin 
                                if(withdraw_amount > ur_balance)
									next_state =eject_card_state;//
								else
									next_state = confirm_withdraw_state;//
                                end  
    confirm_withdraw_state  :begin 
                                if(take_receipt == 1'b0)
									next_state = one_more_transaction;
								else if  (take_receipt == 1'b1)
									next_state = print_state;
                                end  //hi hi hi hi hi
    print_state             :begin

                                    next_state = one_more_transaction;
                            end

    transfer_state     		: begin
									next_state = confirm_account_state;
								end
							
    confirm_account_state   : begin
                                if(chances_Taccount == 2'b11)
                                  next_state = eject_card_state;
				                  else begin
								      for(i=0;i<3;i=i+1)begin
                                      if(account[i][0]== Pers_Account_No) begin
                                        if(account[i][0]==ur_account)// c++ handel
                                            next_state= eject_card_state;
                                        else
                                            next_state= check_transfer_value_state;
                                    end
                                      end
                                      chances_Taccount = chances_Taccount + 1;
                                      next_state = confirm_account_state;
                                      end			  
								end
							
    check_transfer_value_state     	: begin
								if(Transfer_Amount <= ur_balance)
									next_state = confirm_transfer_state;
								else
									next_state = eject_card_state;			  
								end
    confirm_transfer_state     	: begin
								if(take_receipt == 1'b0)
									next_state = one_more_transaction;
								else if  (take_receipt == 1'b1)
									next_state = print_state; 		  
								end
            

    balance_state:          begin
                                if (Receipt == 1'b1)
                                    next_state = print_state;
                                else
                                    next_state = one_more_transaction;
                            end   

    deposit_state:          begin
                                if (money_counting == 1'b1)
                                    next_state = confirm_deposit_state;
                                else
                                    next_state = eject_card_state;
                            end
    confirm_deposit_state:          begin
                                
                                    next_state = one_more_transaction;
                            end



    change_pin_state:       begin 
                                next_state = confirm_pin_state;
                            end

    confirm_pin_state:      begin 
                                next_state =one_more_transaction;
                            end   
                                                      
    eject_card_state:          begin next_state = Idle; end

    one_more_transaction:          begin next_state = home_state; end
    default:                    next_state = Idle;

    endcase
    end


    //Output combinational logic
    always @(*)
    begin
    case(current_state)
       
        insert_card_state:
        eject_card_state:   begin
                                ATM_Usage_Finished        = 1'b1;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrawed_Successfully   = 1'b0;
                                Transfer_Done             = 1'b0;
        end

        withdraw_state:     begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrawed_Successfully   = 1'b1;
                                Transfer_Done             = 1'b0;
                            end


        transfer_state:     begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrawed_Successfully   = 1'b0;
                                Transfer_Done             = 1'b1;
                            end
                    

        balance_state:      begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b1;
                                Deposited_Successfully    = 1'b0;
                                Withdrawed_Successfully   = 1'b0;
                                Transfer_Done             = 1'b0;
                            end

        deposit_state:      begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b1;
                                Withdrawed_Successfully   = 1'b0;
                                Transfer_Done             = 1'b0;
                            end

        eject_card_state:   begin
                                ATM_Usage_Finished        = 1'b1;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrawed_Successfully   = 1'b0;
                                Transfer_Done             = 1'b0;
                            end                    

        default:            begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrawed_Successfully   = 1'b0;
                                Transfer_Done             = 1'b0;
                            end
    endcase
    end


endmodule;
