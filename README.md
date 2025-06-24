# 🏦 Banking System (Verilog & C++)
## 📌 Project Overview
This project implements a Banking System using two approaches:
- **Verilog**: Hardware-based design using a Finite State Machine (FSM)
- **C++**: Software-based model for functional reference and verification
The goal is to compare hardware execution with software logic.

---

## ✅ Features
- ✔️ User authentication (PIN verification)
- ✔️ Balance inquiry
- ✔️ Deposit and withdrawal operations
- ✔️ Money transfer between accounts
- ✔️ PIN change functionality
- ✔️ Error handling for incorrect PINs, invalid accounts, and insufficient funds
- ✔️ Verilog: FSM-based transaction logic
- ✔️ C++: Modular, object-oriented implementation for behavioral modeling

---

## 🚀 Getting Started

### 🔧 Requirements

#### 🔲 Verilog Version
- Verilog simulator
- Waveform viewer
- Git for version control

#### 🔲 C++ Version
- C++ compiler
- Any IDE or terminal

---

## 💾 Running the Project

### ▶️ Verilog (FSM Hardware Logic)
1. Clone the repo  
2. Compile `ATM_Banking_System.v`
3. Run the testbench (`ATM_Banking_System_tb.v`)  
4. View results using a waveform viewer 

### ▶️ C++ (Reference Model)
1. Navigate to the C++ source file (`REFERENCE.cpp`)  
2. Compile the program  
3. Run the executable

---



## 🔄 Hardware vs Software Comparison

| Feature              | Verilog (Hardware)       | C++ (Software)        |
|----------------------|--------------------------|------------------------|
| Execution Speed      | High (FPGA-accelerated)  | Medium (CPU-bound)     |
| Concurrency          | Parallel                 | Sequential             |
| Debugging            | Waveform simulation      | Step-by-step debugger  |
| Flexibility          | Requires re-synthesis    | Easily modifiable      |
| Power Efficiency     | High                     | Lower                  |

---


## 📌 Example Transactions

### ✅ Login & Balance Check

Enter PIN: **** (Correct)
Access Granted
Balance: $1000

### 💵 Deposit

Enter deposit amount: $500
New Balance: $1500

### ❌ Withdraw (Insufficient Funds)

Enter withdrawal amount: $2000
Error: Insufficient Funds
