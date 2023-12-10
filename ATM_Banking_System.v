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
input clk, rst, Card_in, Language, Timer, money_counting, another_transaction_bit // hi
input[2:0] opcode,
input[13:0] password, new_pin,
input allowwithdraw,take_receipt,allow_transfer,
input wire  [15:0] Pers_Account_No, ur_account,
input wire  [31:0] withdraw_amount,Transfer_Amount,
output reg Transfered_Successfully, ATM_Usage_Finished, Balance_Shown, Deposited_Successfully, Withdrew_Successfully
// don't forget to add your outputs 7ader 7ader2
);
integer i;
wire [13:0] ur_pin,ur_balance;
reg[3:0] current_state, next_state;
reg[1:0] chances_Pin = 2'b00;
reg[1:0] chances_Taccount = 2'b00;
reg[1:0] chances_ur_account = 2'b00;
reg[3:0] account_sn, transi;


reg [15:0] account [0:number_of_accounts-1][0:2] =
{	{50602, 8030, 5000},
    {28764, 1215, 8000},
    {12825, 1234, 7500},
    {34345, 3333, 3000}
};



parameter[3:0]  idle_state                  = 4'b00000,
                insert_card_state           = 4'b00001,
                language_state              = 4'b00010,
                pin_state                   = 4'b00011,
                home_state                  = 4'b00100,
                balance_state               = 4'b00101,
                withdraw_state              = 4'b00110,
                deposit_state               = 4'b00111,
                transfer_state              = 4'b01000,
                check_transfer_value_state  = 4'b01001, 
                print_state                 = 4'b01010,
                eject_card_state            = 4'b01011,
                another_transaction         = 4'b01100,
                change_pin_state            = 4'b01101,
                receipt_state               = 4'b01110,
                confirm_withdraw            = 4'b01111,
                confirm_transfer            = 4'b10000,
                confirm_deposit             = 4'b10001;

parameter[3:0] number_of_accounts = 4'd4;
            

					
					 

//State register logic
    always@(posedge clk or negedge reset or posedge timer) begin
        if(~reset)
            current_state <= idle_state;
        else if(timer)
            current_state <= eject_card_state;
        else
            current_state <= next_state; 
    end



//Next State combinational logic
    always @(*)
    begin
    case(current_state)
    idle_state     		: begin
                        if(Card_in == 1'b1)
                            next_state = insert_card_state ;
                        else
                            next_state = idle_state ;			  
                    end

	insert_card_state   :begin  //takes the user account

                                for(i=0;i<number_of_accounts;i=i+1) begin
                                    if(account[i][0] == ur_account) begin
                                        account_sn = i;
                                        next_state= language_state;
                                    end
                                end  
                                next_state = eject_card_state; 	  
                        end
				 
        
    language_state : begin //chooses language from the system
                        next_state = pin_state;		  
                    end

    pin_state       : begin
                        if(chances_Pin == 2'b11)
                        next_state = eject_card_state;
				        else if(password != ur_pin) begin
                            chances_Pin = chances_Pin + 1;
					        next_state = pin_state;
                        end
                        else
					        next_state = home_state;
                        
    end
    
    home_state      : begin //user pick operation
                            if(opcode == 3'b000)
                                next_state = eject_card_state;
                            else if(opcode == 3'b001)
                                next_state = balance_state;
                            else if(opcode == 3'b010)
                                next_state = withdraw_state;
                            else if(opcode == 3'b011)
                                next_state = deposit_state;
                            else if(opcode == 3'b100)
                                next_state = transfer_state;
                            else if(opcode == 3'b101)
                                next_state = change_pin_state;
                    end

    withdraw_state     	: begin  //takes the money value
                                if(withdraw_amount > ur_balance)
                                    next_state = eject_card_state;
                                else
                                    next_state = confirm_withdraw;
						end

    confirm_withdraw    : begin
                            account[account_sn][2] = account[account_sn][2] - withdraw_amount;
                            next_state = receipt_state;
                        end

    receipt_state:          begin 
                                    if(take_receipt == 1'b0)
                                        next_state = another_transaction;
                                    else
                                        next_state = print_state;
                            end  



    print_state             :begin //printed the receipt
                                next_state = another_transaction;
                            end


transfer_state   : begin    //takes account from user
                            if(chances_Taccount == 2'b11)
                                next_state = eject_card_state;
                            else begin
                                if(Pers_Account_No == ur_account)
                                    next_state= eject_card_state;
                                else begin
                                for(i=0;i<number_of_accounts;i=i+1) begin
                                    if(account[i][0] == Pers_Account_No) begin
                                        transi=i;
                                        next_state= check_transfer_value_state;
                                    end
                                end
                                
                            chances_Taccount = chances_Taccount + 1;
                            next_state = transfer_state;
                            end		
                            end 
						end
							
check_transfer_value_state   : begin //takes transfer amount
                                if(Transfer_Amount <= account[account_sn][2]) 
                                    next_state = confirm_transfer;
                                else 
                                    next_state = eject_card_state;		
                            end

    confirm_transfer: begin
                        account[account_sn][2] = account[account_sn][2] - Transfer_Amount;
                        account[transi][2]= account[transi][2] + Transfer_Amount;
                        next_state = receipt_state; 
    end
    balance_state:          begin //displays balance
                                next_state = receipt_state;
                            end   

    deposit_state:          begin
                                    if (money_counting == 1'b1) //if money is deposited money_counting = 1
                                        next_state = confirm_deposit;
                            end

    confirm_deposit:    begin
                            account[account_sn][2] = account[account_sn][2] + deposit_amount;
                            next_state = receipt_state;
                        end


    change_pin_state:       begin 
                                    account[account_sn][1] = new_pin;
                                    next_state = another_transaction;
                            end   
                                                      
    eject_card_state:       begin 
                                next_state = idle_state; 
                            end

    another_transaction:    begin 
                                    if(another_transaction_bit == 1b'1)
                                        next_state = home_state; 
                                    else
                                        next_state = eject_card_state;
                            end

    endcase
    end


    //Output combinational logic
    always @(*)
    begin
    case(current_state)
    
        idle_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end
        
        language_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end
        
        insert_card_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0; 

        end
        pin_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end
        home_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end

        balance_state:      begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b1;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;
                            end

        withdraw_state:     begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;
                            end

        deposit_state:      begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;
                            end

        transfer_State:     begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;
                            end
                    
        eject_card_state:   begin
                                ATM_Usage_Finished        = 1'b1;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;
                            end                    

        check_transfer_value_state: begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end
        print_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b1;

        end
        another_transaction:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end
        change_pin_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b1;
                                Receipt_Printed           = 1'b0;

        end
        receipt_state:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end

        confirm_withdraw:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b1;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end

        confirm_deposit:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b1;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b0;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end

        confirm_transfer:   begin
                                ATM_Usage_Finished        = 1'b0;
                                Balance_Shown             = 1'b0;
                                Deposited_Successfully    = 1'b0;
                                Withdrew_Successfully     = 1'b0;
                                Transfer_Successfully     = 1'b1;
                                Pin_Changed_Successfully  = 1'b0;
                                Receipt_Printed           = 1'b0;

        end
    endcase
    end


endmodule;
