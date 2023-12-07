module ATM (
input[2:0] opcode,
input[3:0] password

// don't forget to add your outputs 
);

reg[1:0] chances = 2'00;
reg[3:0] visa_password = 4'b1110;
reg[3:0] current_state, next_state;


parameter[3:0]  insert_card_state = 4'b0000,
                language_state = 4'b0001,
                pin_state = 4'b0010,
                home_state = 4'b0011
                balance_state = 4'b0100,
                withdraw_state = 4'b0101,
                deposit_state = 4'b0110,
                transfer_state = 4'b0111,
                display_state = 4'b1000,
                allow_withdraw_state = 4'b1001,
                amount_state = 4'b1010,
                allow_transfer_state = 4'b1011,
                confirm_state = 4'b1100,
                print_state = 4'b1101,
                eject_card_state = 4'b1110;
					
					 

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
					        next_state = home_state ;	  
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
                            
    endcase
    end


    //Output combinational logic
    always @(*)
    begin
    case(current_state)
       
    endcase
    end


endmodule;