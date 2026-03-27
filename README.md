# 🧠 RV32I Pipelined Processor (Verilog)

## 📌 Overview
This project implements a 5-stage pipelined RISC-V (RV32I subset) processor using Verilog.  
The design demonstrates instruction-level parallelism through pipelining and includes core components such as ALU, register file, control unit, and memory modules.

---

## 🏗️ Architecture

The processor is divided into the following pipeline stages:

1. **IF (Instruction Fetch)**  
2. **ID (Instruction Decode)**  
3. **EX (Execute)**  
4. **MEM (Memory Access)**  
5. **WB (Write Back)**  

Pipeline registers are used between each stage to ensure proper data flow.

---

## ⚙️ Features

- 5-stage pipelined architecture  
- Instruction execution using RV32I base subset  
- Modular RTL design (ALU, Control Unit, Register File, Memory)  
- Simulation-based verification  
- Clean separation of datapath and control logic  

---

## 🔍 Current Status

✅ Base pipeline implementation completed  
✅ Instruction execution verified through simulation  
🚧 Hazard handling (data/control hazards) – In Progress  
🚧 Branch prediction – Planned  

---

## 🧪 Simulation & Results

- Functional verification performed using testbenches  
- Instruction flow validated across pipeline stages  
- Waveforms confirm correct execution of instructions  


---

## 🧱 Modules

- ALU  
- Register File  
- Control Unit  
- Instruction Memory  
- Data Memory  
- Pipeline Registers  

---

## 📌 Applications

- Understanding pipelined processor design  
- Instruction-level parallelism concepts  
- Foundation for advanced CPU design (hazards, forwarding, branch prediction)  

---

## 🚀 Future Work

- Implement hazard detection and forwarding unit  
- Add branch prediction mechanism  
- Extend instruction support  
- Optimize pipeline performance  

---

## 🛠️ Tools Used

- Verilog HDL  
- Xilinx Vivado  
- Simulation Testbenches  

---

## 📂 Repository Structure
/source -> RTL design files
/testbench -> Simulation testbenches
/docs -> Diagrams and explanations