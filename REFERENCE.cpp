/*
TITLE:		SIMPLE ATM MACHINE

PURPOSE:	Write a program that simulates as an atm machine

TASKS:		Create an account that has the ability to 
				1) Check checking account balance
				2) Check savings account balance
				3) Make transfers between each account
				4) Make deposits into accounts
				5) Make withdrawals from accounts

AUTHOR:		Nadine E. Jerome

INSTRUCTIONS:	
			Enter pin number '1234'
			Checkings Account Balance = 100
			Savings Account Balance = 600
*/


#include <iostream>
#include <string>
#include <chrono>
#include <thread>
using namespace std;

//global variable
int account_sn;
const int numberOfAccounts = 4;


// FUNCTIONS
void home();
void account(int option);

//string AccountType[] = {"", "CHECKINGS", "SAVINGS"};
char response;
/*
int AccountDetails[] = {
	506021,      // accout number
	8030,		// pin number
	5000,	    // Balance

};
*/



bool validatePin(int pin) {
	for(int i = 0; i < numberOfAccounts; i++){
		if (pin == accounts[i][1]) {
			account_sn = i;
			return true;
		} else {
			return false;
		}
	}
}


// useless..?
bool proceed(char response) {
	while(true){
		if(response =="y" || response == "Y"){
			return true;
		} else if(response == "n" || response == "N"){
			return false;
		}
		else{
			cout << "\nYou must type either Y or N"<<endl;
		}
	}
}

//useless?
bool waitForUserInput(int maxSeconds) {
	auto startTime = chrono::system_clock::now();
	this_thread::sleep_for(chrono::seconds(maxSeconds));
	auto endTime = chrono::system_clock::now();
	auto elapsedSeconds = chrono::duration_cast<chrono::seconds>(endTime - startTime).count();
	return elapsedSeconds < maxSeconds;
}

///////////////////////////////////////////////////////////////
class AccountSettings {
	private:		
		int* account_num;
		int* pin;	
		int* balance;	
	
	public:
		AccountSettings(){
			account_num = accounts[account_sn][0];
			pin = accounts[account_sn][1];
			balance = accounts[account_sn][2];
		}
		
		void withdraw_state();
		void allow_withdraw_state();
		void confirm_state();
		void print();
		void deposit_state();
		void Transfer_state();
		void Confirm_account_state();
		void allow_transfer_state();
		void balance_state();
		void change_pin();
		void another_transaction();

		void another_transaction(){
			cout<<"Do you want to make another transaction?"<<endl;
			bool cont;
			cin >> cont;
			if(cont) home();
			else idle();
		}

		void change_pin(int newPin){
			*pin = newPin;
		}
		
		
		void withdraw_state(){
			int withdraw_amount;
			cout << "Please enter amount to withdrawn:\n" << endl;
			cin >> withdraw_amount;
			allow_withdraw_state(withdraw_amount);
			
		}

		void allow_withdraw_state(int withdraw_amount) {
			if(withdraw_amount <= this->balance){
				this->balance -= withdraw_amount;
				cout << "Dispensing... ";
				cout << "$"<< withdraw_amount << endl;
				confirm_state();
			} else {
				cout << "Insufficent funds..ejecting card" << endl;
				eject_card_state();
			}
		}

		void confirm_state(){
			cout<<"Do you want to print a receipt?"<<endl;
			char take_receipt;
			cin >> take_receipt;
			bool resp = proceed(take_receipt);
			if (resp)
				print();
			else
				another_transaction();
		}
		
		void print() {
			cout<<"your account balance is:	 "<<balance<<endl;
			cout<<"your account type is   :	 "<<type<<endl;
			another_transaction();
		}

		void deposit_state() {
			int deposit_amount;
			cout << "Please enter an amount to deposit: ";
			cin >> deposit_amount;
			
			balance += deposit_amount;
			cout << "$" << deposit_amount << " was deposit successfully\n";
			
			char next;
			cout << "Back to menue (y\n)? ";
			cin >> next;
			
			if (next == 'y' || next == 'Y')
				home();
			else 
				eject_card_state();
		}
		
	/*
		int getDeposit() {
			int deposit_amount;
			cout << "Please enter an amount to deposit:\n" << endl;
			cin >> deposit_amount;

			int AccountBalance = this->balance += deposit_amount;

			// update the account balance
			accounts[this->type] = AccountBalance;

			cout << "\t$" << deposit_amount << " was deposited into your account";
			getBalance();
			 
			return 0;
		}
	*/
	
		void Transfer_state() {
			int  allow_transfer;
			// int TransferTo = this->type== 1 ? 2 : 1;
            cout<<"Welcome to Transfer State  if you want to continue press 1 if you want to return home press 0";
            cin>> allow_transfer;
			if( allow_transfer==1)
			 Confirm_account_state();
		    else if(allow_transfer== 0)
		      home();
		    else{
		      cout<<"Please select 1 or 0 only";
		      Transfer_state();}
		}
		
		void Confirm_account_state(){
			cout << "Enter your account number for verification";
				int account_num;
				cin >> account_num;
			if(account_num == this->account_num){
				cout << "Verifired";
				allow_transfer_state();}
			else{
				cout << "Incorrect account ID";
				Transfer_state();
			}
		}
			
		void allow_transfer_state(){
			int AmountTransfer;
			cout << "Enter amount to transfer "<< endl;
			cin >>  AmountTransfer;
			if(AmountTransfer <= accounts[account_sn][2]){
				accounts[account_sn][2] = this->balance -= AmountTransfer;
				cout << "$" << AmountTransfer << " has been transfered and deducted from your account" << endl;
				confirm_state();
			} else {
				cout << "Insuffient funds." << endl;
				Transfer_state();}
		}

		void balance_state() {
			char print;
			cout << "Your account balance is $" << this->balance << endl;
			cout << "Do you want to print the account balance (y/n)? ";
			cin >> print;
			if (print == 'y' || print == 'Y')
				print();
			else {
				char next;
				cout << "Back to menue (y\n)? ";
				cin >> next;
				
				if (next == 'y' || next == 'Y')
					home();
				else 
					eject_card_state();	
			}
		}
		
	/*		
		void getBalance() {	
			char confirmBalance, response;
			// get the account type, and return balance
			cout << "Would you like to check your "<< AccountType[this->type] << " account balance? (y/n)\n" << endl;
			cin >> confirmBalance;
			if(confirmBalance=='y' || confirmBalance=='Y'){
				cout << "Your account balance is: $" << this->balance << endl;
			} 
			cout << "\n\nWould you like to continue (y/n)?\n";
			cin >> response;

			if (proceed(response)) {        
				account(this->type); // return to account menu
			}

			return 0;
		}
	*/
};

void account(int option) {
    if(option >= 1 && option <= 5){
		// Pass in account type
		switch(option){
			case 1:
				Account.getBalance();
				break;
			case 2: 
				Account.allow_withdraw_state();
				break;
			case 3: 
				Account.getDeposit();
				break;
			case 4:
				Account.getTransfer();
				break;
			case 5:
				int newPin;
				cout << "Enter the new pin";
				cin >> newPin;
				cout << Account.changePin(newPin);
				break;
				
		}
	}
	else{
		cout << "Invalid input.. goint back to ";
	}
}


void home() {
	int option;
	cout << "Main Menu--" <<endl;
	cout << "\tPlease make a selection. " << endl;
	cout << "\n\t1. Check balance"
				<<"\n\t2. Withdraw"
				<<"\n\t3. Deposit"
				<<"\n\t4. Transfer"
				<<"\n\t5. Change Pin" << endl;

	int maxSeconds = 10;
    cout << "Enter an option within " << maxSeconds << " seconds:" << endl;

    if (waitForUserInput(maxSeconds)) {  //5alas?
        cin >> option;
        account(option);
    } else {
        cout << "Error: Timed out waiting for user input." << endl;
		//call exit function here
    }
	
}

void idle(){  // NO TIMER!
	cout << "\nWelcome to the Bank.\n\tPlease enter your pin number to access your account:" << endl;
	int pin, account_num, chances = 0;
	
	while(chances < 3){
		cin >> pin;

		if(validatePin(pin)) {
			cout << endl;

			AccountSettings Account; 
			home(); // continue to main menu
			break;
		} else {
			cout << "Invalid pin. Please enter pin number:" << endl; 
			chances++;
		}
	}
}

void eject_card_state() {
	cout << "Thank you for being our client\nSee you soon\n";
	delete Account;
	cout<<"Card Ejected\n\n";
	idle();
}

// Begin MAIN
int main() {
	int accounts[numberOfAccounts][3] = {
		{50602, 8030, 5000},
		{28764, 1215, 8000},
		{12825, 1234, 7500},
		{34345, 3333, 3000},
	};

	idle();

	return 0;
}

//--Malak
////////validate ACCOUNT....
/////// all functions in class, and obj in main -----maybe not?
///// make idle func.


