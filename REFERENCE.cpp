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

// FUNCTIONS
void home();
void account(int option);

//string AccountType[] = {"", "CHECKINGS", "SAVINGS"};
string response;

int AccountDetails[] = {
	8030,		// pin number
	5000,	    // Balance
	50602,      // accout id

};


bool validatePin(int pin) {
	if (pin == AccountDetails[0]) {
		return true;
	} else {
		return false;
	}
}

bool proceed(string response) {
	if(response =="y" || response == "Y"){
		return true;
	} else if(response == "n" || response == "N"){
		string exit;
		cout << "\n\n\n\t Thank you for banking with us.";
		cin >> exit;
		return false;
	}

}

///////////////////////////////////////////////////////////////
class AccountSettings {
	private:			
		int balance;	
	
	public:
		AccountSettings(){
			this->balance = AccountDetails[1];
		}
		
		void eject_card_state();
		void withdraw_state();
		int allow_withdraw_state();
		void confirm_state();
		void print();
		void deposite_state();
		void Transfer_state();
		void Confirm_account_state();
		void allow_transfer_state();
		void balance_state();
		
		void eject_card_state() {
			cout << "Thank you for being our client\nSee you soon\nCard Ejected\n\n";
		}
		
		void withdraw_state(){
			int allowwithdraw;
			cout <<"if you want to allow withdraw enter 1 else enter 0";
			cin >> allowwithdraw;
			if (allowwithdraw == 1)
				allow_withdraw_state();
			else if (allowwithdraw == 0)
				home();
			else {
				cout<<"ERROR allowed values are 1 and 0 only";
				withdraw_state();
			}
		}

		int allow_withdraw_state() {
			int withdraw_amount;
			cout << "Please enter amount to withdrawn:\n " << endl;
			cin >> withdraw_amount;

			// get account type
			if(withdraw_amount <= this->balance){
				int AccountBalance = this->balance -= withdraw_amount;
				cout << "Dispensing... ";
				cout << "$"<< withdraw_amount << endl;
				
				// update the account balance
			//	AccountDetails[this->type] = AccountBalance;
				//getBalance();
				confirm_state();

			} else {
				cout << "Insufficent funds" << endl;
				//getBalance();
				withdraw_state();
			}

			return 0;
		}

		void confirm_state(){
			cout<<"if you want to take a receipt enter 0 else enter 1";
			int take_receipt;
			cin >>take_receipt;
			if (take_receipt ==0)
			home();
			else if (take_receipt==1 )
			print ();
			else 
			{
				cout <<"WRONG OUTPUT\nthe allowed values of take_receipt are 1 and 0 ";
				confirm_state();
			} 
		}
		
		void print() {
		cout<<"your account balance is:	 "<<balance;
		cout<<"your account type is   :	 "<<type;
		home();
		}

		void deposite_state() {
			int depositAmount;
			cout << "Please enter an amount to deposit:\n";
			cin >> depositAmount;
			
			this->balance += depositAmount;
			cout << "$" << depositAmount << " was deposit successfully\n";
			
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
			int depositAmount;
			cout << "Please enter an amount to deposit:\n" << endl;
			cin >> depositAmount;

			int AccountBalance = this->balance += depositAmount;

			// update the account balance
			AccountDetails[this->type] = AccountBalance;

			cout << "\t$" << depositAmount << " was deposited into your account";
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
			if(account_num == AccountDetails[3]){
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
			if(AmountTransfer <= AccountDetails[2]){
				AccountDetails[2] = this->balance -= AmountTransfer;
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
    if(option >= 1 && option <= 4){
		// Pass in account type
		AccountSettings Account; 
		switch(option){
			case 1:
				cout << Account.getBalance();
				break;
			case 2: 
				cout << Account.allow_withdraw_state();
				break;
			case 3: 
				cout << Account.getDeposit();
				break;
			case 4:
				cout << Account.getTransfer();
				break;
		}
	}
	else{
		cout << "Invalid input.. goint back to ";
	}
}

bool waitForUserInput(int maxSeconds) {
	auto startTime = chrono::system_clock::now();
	this_thread::sleep_for(chrono::seconds(maxSeconds));
	auto endTime = chrono::system_clock::now();
	auto elapsedSeconds = chrono::duration_cast<chrono::seconds>(endTime - startTime).count();
	return elapsedSeconds < maxSeconds;
}

void home() {
	int option;
	cout << "Main Menu--" <<endl;
	cout << "\tPlease make a selection. " << endl;
	cout << "\n\t1. Check balance"
				<<"\n\t2. Withdraw"
				<<"\n\t3. Deposit"
				<<"\n\t4. Transfer "<< endl;

	int maxSeconds=10;
    cout << "Enter an option within " << maxSeconds << " seconds:" << endl;

    if (waitForUserInput(maxSeconds)) {
        cin >> option;
        account(option);
    } else {
        cout << "Error: Timed out waiting for user input." << endl;
		//call exit function here
    }
	
}


// Begin MAIN
int main() {
	cout << "\nWelcome to the Bank.\n\tPlease enter your pin number to access your account:" << endl;
	int pin, chances = 0;

	while(chances < 3){
		cin >> pin;

		if(validatePin(pin)) {
			cout << endl;
			home(); // continue to main menu
			break;
		} else {
			cout << "Invalid pin. Please enter pin number:" << endl; 
			chances++;
		}
	}

	return 0;
}
