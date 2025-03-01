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

2️⃣ Run the testbench

3️⃣ View the waveform

C++ Version
1️⃣ Navigate to the C++ directory

2️⃣ Compile the program

3️⃣ Run the program

🔄 Comparison: Verilog vs C++
Feature	Verilog (Hardware)	C++ (Software)
Execution Speed	Fast (FPGA-based)	Slower (CPU-based)
Concurrency	High (parallelism)	Sequential execution
Flexibility	Limited (FPGA logic)	High (easy to update)
Power Efficiency	High	Low
Debugging	Waveforms & simulation	Debugging tools & logs
📜 Verilog Finite State Machine (FSM)
📌 Example Transactions
Login & Balance Check

Enter PIN: **** (Correct)
Access Granted ✅
Current Balance: $1000
Deposit
Enter deposit amount: $500
New Balance: $1500
Withdraw
Enter withdrawal amount: $2000
❌ Error: Insufficient Funds
🧪 Testing
Verilog: Testbench simulation + waveform analysis
C++: Unit tests for each function
