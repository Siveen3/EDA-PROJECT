module ATM (
input[2:0] opcode,
input[13:0] password,
input allowwithdraw,take_receipt,allow_transfer,
input wire  [15:0] Pers_Account_No,
input wire  [31:0] withdraw_amount,Transfer_Amount,
output reg Transfer_Done, ATM_Usage_Finished, Balance_Shown, Deposited_Successfully, Withdrawed_Successfully;
// don't forget to add your outputs 7ader 7ader2
);

reg[3:0] current_state, next_state;
reg[1:0] chances = 2'b00;
reg[3:0] visa_password = 13'd8030;
reg [31:0] existing_amount = 32'h000186A0;
reg [15:0] Correct_Account_No = 16'hD903;

parameter[3:0]  insert_card_state   = 4'b0000,
                language_state      = 4'b0001,
                pin_state           = 4'b0010,
                home_state          = 4'b0011,
                balance_state       = 4'b0100,
                withdraw_state      = 4'b0101,
                deposit_state       = 4'b0110,
                transfer_state      = 4'b0111,
                //display_state     = 4'b1000,
                allow_withdraw_state= 4'b1001,
                amount_state        = 4'b1010,
                allow_transfer_state= 4'b1011,
                confirm_state       = 4'b1100,
                print_state         = 4'b1101,
                eject_card_state    = 4'b1110,
                Confirm_account_state=4'b1111;
					
					 

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
        
    language_state : begin
                        next_state = pin_state;		  
                    end

    pin_state       : begin
                        if(chances == 2'b11)
                        next_state = eject_card_state;
				        else if(password != visa_password) begin
                            chances = chances + 1;
					        next_state = pin_state;
                        end
				        else 
					        next_state = home_state;	  
			        end
    
    home_state      : begin
                        if(opcode == 4'b000)
                            next_state = eject_card_state;
                        else if(opcode == 4'b001)
                            next_state = balance_state;
                        else if(opcode == 4'b010)
                            next_state = withdraw_state;
                        else if(opcode == 4'b011)
                            next_state = deposit_state;
                        else if(opcode == 4'b100)
                            next_state = transfer_state;
                        else 
                            next_state = home_state;
                    end
    withdraw_state     		: begin
								if(allowwithdraw == 1'b1)
									next_state =allow_withdraw_state;
								else if (allowwithdraw == 1'b0)
									next_state =home_state;

								else
									next_state = withdraw_state;			  
								end
    allow_withdraw_state    :begin 
                                if(withdraw_amount > existing_amount)
									next_state = withdraw_state;
								else  (withdraw_amount <= existing_amount)
									next_state = confirm_state;
                                

                                end   
    confirm_state            :begin 
                                if(take_receipt == 1'b0)
									next_state = home_state;
								else if  (take_receipt == 1'b1)
									next_state = print_state;
								else 
                                    next_state=confirm_state;	

                                end  

    print_state             :begin

                                    next_state = home_state;
                                end

    transfer_state     		: begin
                                if(allow_transfer==1'b1)
									next_state = Confirm_account_state;
                                else if(allow_transfer==1'b0)
                                    next_state = home_state;	
                                else 
                                	   next_state = transfer_state;
								end
							
    Confirm_account_state   : begin
								if(Pers_Account_No != Correct_Account_No)
									next_state = Confirm_account_state;
								else 
									next_state = allow_transfer_state;			  
								end
							
    allow_transfer_state     	: begin
								if(Transfer_Amount <= existing_amount)
									next_state = confirm_state;
								else
									next_state = allow_transfer_state;			  
								end

    balance_state:          begin
                                if (Receipt == 1'b1)
                                    next_state = print_state;
                                else
                                    next_state = home_state;
                            end   

    deposit_state:          begin
                                if (Money_Deposited == 1'b1)
                                    next_state = confirm_state;
                                else
                                    next_state = home_state;
                            end
                                                        
    eject_card_state:           next_state = Idle;

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
