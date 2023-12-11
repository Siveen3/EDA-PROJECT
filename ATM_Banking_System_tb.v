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

    // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  

  endmodule
