🏦 Banking System (Verilog & C++)
📌 Project Overview
This project implements a Banking System in two different languages: Verilog and C++. The goal is to compare hardware-based (FPGA) and software-based (C++) implementations of basic banking operations.

✅ Features
✔ User authentication (PIN verification)
✔ Balance inquiry
✔ Deposit and withdrawal operations
✔ Error handling for incorrect PINs and insufficient funds
✔ Verilog: Implements a Finite State Machine (FSM) for transactions
✔ C++: Uses OOP (Object-Oriented Programming) for modular design
🚀 Getting Started
🔧 Requirements
Verilog Implementation
Verilog Compiler (Icarus Verilog, ModelSim, or Vivado)
Waveform viewer (GTKWave)
Git for version control
C++ Implementation
C++ Compiler (GCC, Clang, or MSVC)
Any IDE (VS Code, Code::Blocks, or CLion)
Git for version control
💾 Installation & Running
Verilog Version
1️⃣ Clone the repository

bash
Copy
Edit
git clone https://github.com/YOUR_USERNAME/Banking-System.git
cd Banking-System/verilog/src
2️⃣ Run the testbench

bash
Copy
Edit
iverilog -o bank_test testbench.v
vvp bank_test
3️⃣ View the waveform

bash
Copy
Edit
gtkwave output.vcd
C++ Version
1️⃣ Navigate to the C++ directory

bash
Copy
Edit
cd Banking-System/cpp/src
2️⃣ Compile the program

bash
Copy
Edit
g++ -o banking_system main.cpp Bank.cpp User.cpp
3️⃣ Run the program

bash
Copy
Edit
./banking_system
🔄 Comparison: Verilog vs C++
Feature	Verilog (Hardware)	C++ (Software)
Execution Speed	Fast (FPGA-based)	Slower (CPU-based)
Concurrency	High (parallelism)	Sequential execution
Flexibility	Limited (FPGA logic)	High (easy to update)
Power Efficiency	High	Low
Debugging	Waveforms & simulation	Debugging tools & logs
📜 Verilog Finite State Machine (FSM)
txt
Copy
Edit
[IDLE] → [AUTHENTICATE] → [MENU] → { [CHECK_BALANCE] | [DEPOSIT] | [WITHDRAW] } → [IDLE]
📌 Example Transactions
Login & Balance Check
pgsql
Copy
Edit
Enter PIN: **** (Correct)
Access Granted ✅
Current Balance: $1000
Deposit
nginx
Copy
Edit
Enter deposit amount: $500
New Balance: $1500
Withdraw
javascript
Copy
Edit
Enter withdrawal amount: $2000
❌ Error: Insufficient Funds
🧪 Testing
Verilog: Testbench simulation + waveform analysis
C++: Unit tests for each function
