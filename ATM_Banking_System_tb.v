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
   reg index,index2;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  reg[1:0] chances_Pin ;
reg[1:0] chances_Taccount;
parameter[3:0] number_of_accounts = 4'd4;
reg [31:0] account [0:number_of_accounts-1][0:2];
   initial begin
   account[0][0] = 17'hC5AA; account[0][1] = 17'h1F5E; account[0][2] = 17'h1388;//accout pin balance
    account[1][0] = 17'h705C; account[1][1] = 17'h4BF; account[1][2] = 17'h1F40;
    account[2][0] = 17'h3219; account[2][1] = 17'h4D2; account[2][2] = 17'h1D4C;
    account[3][0] = 17'h8629; account[3][1] = 17'hD05; account[3][2] = 17'hBB8;
    chances_Pin = 2'b00;
    chances_Taccount = 2'b00;
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
    if (Transfer_Successfully || ATM_Usage_Finished || Balance_Shown || Deposited_Successfully || 
        Withdrew_Successfully || Pin_Changed_Successfully || Receipt_Printed) begin
      $display("Error! Reset Issue");
      $stop;    
    end

    reset = 1'b1;

 /*  
  // Test Scenario 1: Successful Withdrawal

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select withdraw operation
  opcode = 3'b010; // Withdraw operation
  withdraw_amount = 500; // Set withdrawal amount
  #20;

  // Confirm withdrawal
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 1 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 1)
    $display("Test Scenario 1: Successful Withdrawal - Passed");
  else
    $display("Test Scenario 1: Successful Withdrawal - Failed");




// Test Scenario 2: Invalid PIN, Eject Card

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter invalid PIN
  password = 17'h1234; // Use an invalid PIN
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 2: Invalid PIN, Eject Card - Passed");
  else
    $display("Test Scenario 2: Invalid PIN, Eject Card - Failed");




// Test Scenario 3: Check Balance

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select balance inquiry operation
  opcode = 3'b001; // Balance inquiry operation
  #20;

  // Confirm balance inquiry
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 1 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 1)
    $display("Test Scenario 3: Check Balance - Passed");
  else
    $display("Test Scenario 3: Check Balance - Failed");




// Test Scenario 4: Successful Deposit

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select deposit operation
  opcode = 3'b011; // Deposit operation
  deposit_amount = 1000; // Set deposit amount
  money_counting = 1; // Signal money counting
  #20;

  // Confirm deposit
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 1 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 1)
    $display("Test Scenario 4: Successful Deposit - Passed");
  else
    $display("Test Scenario 4: Successful Deposit - Failed");




// Test Scenario 5: Successful Transfer

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select transfer operation
  opcode = 3'b100; // Transfer operation
  Pers_Account_No = 17'h4D2; // Set recipient account
  Transfer_Amount = 200; // Set transfer amount
  #20;

  // Confirm transfer
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 1 && Pin_Changed_Successfully == 0 && Receipt_Printed == 1)
    $display("Test Scenario 5: Successful Transfer - Passed");
  else
    $display("Test Scenario 5: Successful Transfer - Failed");




// Test Scenario 6: Change PIN

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter current PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select change PIN operation
  opcode = 3'b101; // Change PIN operation
  new_pin = 17'hABCDE; // Set new PIN
  #20;

  // Confirm PIN change
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 1 && Receipt_Printed == 1)
    $display("Test Scenario 6: Change PIN - Passed");
  else
    $display("Test Scenario 6: Change PIN - Failed");




// Test Scenario 7: Insufficient Balance for Withdrawal

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select withdraw operation
  opcode = 3'b010; // Withdraw operation
  withdraw_amount = 1500; // Set withdrawal amount greater than balance
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 7: Insufficient Balance for Withdrawal - Passed");
  else
    $display("Test Scenario 7: Insufficient Balance for Withdrawal - Failed");


/*

// Test Scenario 8: Invalid Transfer Account

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select transfer operation
  opcode = 3'b100; // Transfer operation
  Pers_Account_No = 17'h1111; // Set invalid recipient account
  Transfer_Amount = 200; // Set transfer amount
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 8: Invalid Transfer Account - Passed");
  else
    $display("Test Scenario 8: Invalid Transfer Account - Failed");



// Test Scenario 9: Multiple Transactions

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Perform multiple transactions
  opcode = 3'b001; // Balance inquiry
  #20;
  opcode = 3'b011; // Deposit
  deposit_amount = 300; // Set deposit amount
  money_counting = 1; // Signal money counting
  #20;
  opcode = 3'b010; // Withdraw
  withdraw_amount = 100; // Set withdrawal amount
  #20;

  // Confirm last transaction
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 1 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 1)
    $display("Test Scenario 9: Multiple Transactions - Passed");
  else
    $display("Test Scenario 9: Multiple Transactions - Failed");




// Test Scenario 10: Attempt to Transfer to Own Account

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select transfer operation
  opcode = 3'b100; // Transfer operation
  Pers_Account_No = 17'h1F5E; // Attempt to transfer to own account
  Transfer_Amount = 200; // Set transfer amount
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 10: Attempt to Transfer to Own Account - Passed");
  else
    $display("Test Scenario 10: Attempt to Transfer to Own Account - Failed");




// Test Scenario 11: Attempt to Deposit without Money Counting

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Select deposit operation without money counting
  opcode = 3'b011; // Deposit operation
  deposit_amount = 300; // Set deposit amount
  money_counting = 0; // Signal no money counting
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 11: Attempt to Deposit without Money Counting - Passed");
  else
    $display("Test Scenario 11: Attempt to Deposit without Money Counting - Failed");




// Test Scenario 12: Multiple Unsuccessful PIN Attempts

  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter incorrect PIN multiple times
  for ( i = 0; i < 3; i = i + 1) begin
    password = 17'h0000 + i; // Use incorrect PIN
    #20;
  end

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 12: Multiple Unsuccessful PIN Attempts - Passed");
  else
    $display("Test Scenario 12: Multiple Unsuccessful PIN Attempts - Failed");




// Test Scenario 13: Eject Card Without Transaction

  // Insert card
  Card_in = 1;
  #20;

  // Eject card without performing any transaction
  another_transaction_bit = 0;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 1 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 13: Eject Card Without Transaction - Passed");
  else
    $display("Test Scenario 13: Eject Card Without Transaction - Failed");




// Test Scenario 14: Attempt to Withdraw Without Inserting Card

  // Do not insert card
  Card_in = 0;
  #20;

  // Attempt to perform a withdrawal
  opcode = 3'b010; // Withdraw operation
  withdraw_amount = 100; // Set withdrawal amount
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 14: Attempt to Withdraw Without Inserting Card - Passed");
  else
    $display("Test Scenario 14: Attempt to Withdraw Without Inserting Card - Failed");




// Test Scenario 15: Attempt to Change PIN Without Inserting Card

  // Do not insert card
  Card_in = 0;
  #20;

  // Attempt to change PIN
  opcode = 3'b101; // Change PIN operation
  new_pin = 17'hABCDE; // Set new PIN
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 15: Attempt to Change PIN Without Inserting Card - Passed");
  else
    $display("Test Scenario 15: Attempt to Change PIN Without Inserting Card - Failed");




// Test Scenario 16: Attempt to Print Receipt Without Transaction

  // Insert card
  Card_in = 1;
  #20;

  // Attempt to print receipt without performing any transaction
  opcode = 3'b010; // Withdraw operation
  take_receipt = 1;
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 16: Attempt to Print Receipt Without Transaction - Passed");
  else
    $display("Test Scenario 16: Attempt to Print Receipt Without Transaction - Failed");





// Test Scenario 17: Invalid Operation Code
  // Insert card
  Card_in = 1;
  #20;

  // Enter language
  Language = 1;
  #20;

  // Enter PIN
  password = 17'h1F5E; // Use a valid PIN
  #20;

  // Set invalid operation code
  opcode = 3'b111; // Invalid operation code
  #20;

  // Check expected outputs
  if (Withdrew_Successfully == 0 && ATM_Usage_Finished == 0 && Balance_Shown == 0 && Deposited_Successfully == 0 &&
      Transfer_Successfully == 0 && Pin_Changed_Successfully == 0 && Receipt_Printed == 0)
    $display("Test Scenario 17: Invalid Operation Code - Passed");
  else
    $display("Test Scenario 17: Invalid Operation Code - Failed");

*/
     for (i = 0; i <= 1000; i = i + 1) begin 
      @(negedge clk) 
      index = $urandom(1)%4;
      index2 = $urandom(3)%4;
      while(index == index2)
        index2 = $urandom(2)%4;
      Card_in = $urandom()%2;
      Language = $urandom()%2;
      money_counting = $urandom()%2;
      another_transaction_bit = $urandom()%2;
      opcode = $urandom %8;  // Randomize opcode in the range [0, 7]
      password = account[index][1];
      new_pin = $random();
      take_receipt = $urandom()%2;
      allow_transfer = $urandom()%2;
      Pers_Account_No = account[index2][0];
      ur_account = account[index][0];
      withdraw_amount = $urandom()%32767;
      Transfer_Amount = $urandom()%32767;
      deposit_amount = $urandom()%32767;


    end

end


endmodule
