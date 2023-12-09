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
int *account_num, *pin, *balance;
int accounts[numberOfAccounts][3] = {
		{50602, 8030, 5000},
		{28764, 1215, 8000},
		{12825, 1234, 7500},
		{34345, 3333, 3000},
	};


// FUNCTIONS
void home();
void account(int option);

//string AccountType[] = {"", "CHECKINGS", "SAVINGS"};
//char response;
/*
int AccountDetails[] = {
	50602,      // accout number
	8030,		// pin number
	5000,	    // Balance

};
*/



bool validateAcc(int acc) {
	for(int i = 0; i < numberOfAccounts; i++){
		if (acc == accounts[i][0]) {
			account_sn = i;
			return true;
		} 
	}
	return false;
}

bool validatePin(int pin){
	if(pin == accounts[account_sn][1])
		return true;
	else 
		return false;
}

int findAccount(int acc){ 							// returns account index if found, else returns -1
	for(int i = 0; i < numberOfAccounts; i++){
		if (acc == accounts[i][0]){
			return i;
		}
	}
	return -1;
}


// useless..?
bool proceed(char response) {
	while(true){
		if(response =='y' || response == 'Y'){
			return true;
		} else if(response == 'n' || response == 'N'){
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

/////////////////////////////////
		
		void withdraw_state();
		void allow_withdraw_state(int n);
		void confirm_state();
		void print();
		void deposit_state();
		void Transfer_state();
		void Confirm_account_state();
		void allow_transfer_state(int n);
		void balance_state();
		void change_pin();
		void another_transaction();
		void eject_card_state();

		void another_transaction(){
			cout<<"Do you want to make another transaction? Y or N"<<endl;
			char cont;
			cin >> cont;
			if(proceed(cont)) home();
			else eject_card_state();
		}

		void change_pin(){
			int newPin;
			cout << "Enter the new pin";
			cin >> newPin;
			*pin = newPin;
		}
		
		
		void withdraw_state(){
			int withdraw_amount;
			cout << "Please enter amount to withdrawn:\n" << endl;
			cin >> withdraw_amount;
			allow_withdraw_state(withdraw_amount);
			
		}

		void allow_withdraw_state(int withdraw_amount) {
			if(withdraw_amount <= *balance){
				*balance -= withdraw_amount;
				cout << "Dispensing... ";
				cout << "$"<< withdraw_amount << endl;
				confirm_state();
			} else {
				cout << "Insufficent funds..ejecting card" << endl;
				eject_card_state();
			}
		}

		void confirm_state(){
			cout<<"Do you want to print a receipt? Y or N"<<endl;
			char take_receipt;
			cin >> take_receipt;
			if (proceed(take_receipt))
				print();
			else
				another_transaction();
		}
		
		void print() {
			cout<<"your account balance is:	 " << *balance << endl;
			another_transaction();
		}

		void deposit_state() {
			int deposit_amount;
			cout << "Please enter an amount to deposit: ";
			cin >> deposit_amount;
			
			*balance += deposit_amount;
			cout << "$" << deposit_amount << " was deposit successfully\n";
			
			another_transaction();
		}
		
	
		void Transfer_state() {
			int count = 3, loc, account_num_input;
			cout << "Enter the account you want to transfer to: ";
			while(count != 0){
				cin >> account_num_input;
				loc = findAccount(account_num_input);
				if(loc==-1){
					count--;
					cout << "Incorrect account ID\n" << count << " tries left\n";
				} else{
					cout << "Verifired\n";
					break;
				}
			}
			if(count == 0) eject_card_state();
			else allow_transfer_state(loc);
		}
		
		void allow_transfer_state(int acc){
			int AmountTransfer;
			cout << "Enter amount to transfer: "<< endl;
			cin >>  AmountTransfer;
			if(AmountTransfer <= *balance){
				*balance -= AmountTransfer;
				accounts[acc][2] += AmountTransfer;
				cout << "$" << AmountTransfer << " has been transfered and deducted from your account" << endl;
				confirm_state();
			} else {
				cout << "Insuffient funds." << endl;
				eject_card_state();
			}
		}
			
		void balance_state() {
			cout << "Your account balance is $" << *balance << endl;
			confirm_state();
		}
		
	


void account(int option) {

    if(option >= 1 && option <= 5){
		// Pass in account type
		switch(option){
			case 1:
				balance_state();
				break;
			case 2: 
				withdraw_state();
				break;
			case 3: 
				deposit_state();
				break;
			case 4:
				Transfer_state();
				break;
			case 5:
				change_pin();
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

    if (waitForUserInput(maxSeconds)) {  
        cin >> option;
    } else {
        cout << "Error: Timed out waiting for user input." << endl;
		eject_card_state();
		//call exit function here
    }
	
    if(option >= 1 && option <= 5){
		// Pass in account type
		switch(option){
			case 1:
				balance_state();
				break;
			case 2: 
				withdraw_state();
				break;
			case 3: 
				deposit_state();
				break;
			case 4:
				Transfer_state();
				break;
			case 5:
				change_pin();
				break;
		}
	}
	else{
		cout << "Invalid input.. goint back to ";
	}
	
}

void idle(){  // NO TIMER!
	int pin_input, account_num_input, chances = 3;
	cout<<"\nWelcome to the Bank.\n\tPlease insert your card" << endl;
	cin >> account_num_input;
	if(validateAcc(account_num_input)){
		cout << "Enter your pin number to access your account:" << endl;

		while(chances != 0){
			cin >> pin_input;

			if(validatePin(pin_input)) {
				account_num = &accounts[account_sn][0];
				pin = &accounts[account_sn][1];
				balance = &accounts[account_sn][2];
				home(); // continue to main menu
				break;
			} else {
				chances--;
				cout << "Invalid pin. "<<chances<<" tries left" << endl; 
			}
		}
		eject_card_state(); //incorrect pin
	} else{
		cout << "\nSomething went wrong\n";
		eject_card_state(); //invalid account
	}
}

void eject_card_state() {
	cout << "Thank you for being our client\nSee you soon\n";
	account_num = pin = balance = NULL; 
	cout<<"Card Ejected\n\n";
	idle();
}

// Begin MAIN
int main() {
	idle();

	return 0;
}

//--Malak


