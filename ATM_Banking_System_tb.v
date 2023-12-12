`timescale 1ns / 1ps

module ATM_TB;
  reg clk, reset, Card_in, Language, Timer, money_counting, another_transaction_bit;
  reg [2:0] opcode;
  reg [16:0] password, new_pin;
  reg allowwithdraw, take_receipt, allow_transfer;
  reg [16:0] Pers_Account_No, ur_account;
  reg [18:0] withdraw_amount, Transfer_Amount, deposit_amount;
  wire Transfer_Successfully, ATM_Usage_Finished, Balance_Shown, Deposited_Successfully, Withdrew_Successfully,
  Pin_Changed_Successfully, Receipt_Printed;

  // Instantiate the ATM module
  ATM uut (
    .clk(clk),
    .reset(reset),
    .Card_in(Card_in),
    .Language(Language),
    .Timer(Timer),
    .money_counting(money_counting),
    .another_transaction_bit(another_transaction_bit),
    .opcode(opcode),
    .password(password),
    .new_pin(new_pin),
    .allowwithdraw(allowwithdraw),
    .take_receipt(take_receipt),
    .allow_transfer(allow_transfer),
    .Pers_Account_No(Pers_Account_No),
    .ur_account(ur_account),
    .withdraw_amount(withdraw_amount),
    .Transfer_Amount(Transfer_Amount),
    .deposit_amount(deposit_amount),
    .Transfer_Successfully(Transfer_Successfully),
    .ATM_Usage_Finished(ATM_Usage_Finished),
    .Balance_Shown(Balance_Shown),
    .Deposited_Successfully(Deposited_Successfully),
    .Withdrew_Successfully(Withdrew_Successfully),
    .Pin_Changed_Successfully(Pin_Changed_Successfully),
    .Receipt_Printed(Receipt_Printed)
  );

  integer i;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initialize inputs
  initial begin
    reset = 0;
    Card_in = 0;
    Language = 0;
    Timer = 0;
    money_counting = 0;
    another_transaction_bit = 0;
    opcode = 3'b000;
    password = 16'h0000;
    new_pin = 16'h0000;
    allowwithdraw = 0;
    
    take_receipt = 0;
    allow_transfer = 0;
    Pers_Account_No = 16'h0000;
    ur_account = 16'h0000;
    withdraw_amount = 18'h00000;
    Transfer_Amount = 18'h00000;
    deposit_amount = 18'h00000;

    // Check reset 
    @(negedge clk)
    if (Transfer_Successfully != 0 || ATM_Usage_Finished != 0 || Balance_Shown != 0 || Deposited_Successfully != 0 || 
        Withdrew_Successfully != 0 || Pin_Changed_Successfully != 0 || Receipt_Printed != 0) begin
      $display("Error! Reset Issue");
      $stop;    
    end

    reset = 1'b1;

    for (i = 0; i <= 1000; i = i + 1) begin
      Card_in = $random();
      Language = $random();
      Timer = $random();
      money_counting = $random();
      another_transaction_bit = $random();
      opcode = $random();
      password = $random();
      new_pin = $random();
      allowwithdraw = $random();
      take_receipt = $random();
      allow_transfer = $random();
      Pers_Account_No = $random();
      ur_account = $random();
      withdraw_amount = $random();
      Transfer_Amount = $random();
      deposit_amount = $random();

     
    end   
    $stop();
     end
    
endmodule