module Processor(
    input clk, rst
);
    //pipeline fetch and decode registers
    reg [15:0] IFD_instruction;
    reg [3:0] IDE_opcode;
    reg [2:0] IDE_dest_addr, IDE_s1_addr, IDE_s2_addr;
    reg IDE_mode, IDE_mem_wr, IDE_res_we;
    reg [7:0] IDE_data, IDE_s1, IDE_s2;
    
    //execution state registers
    reg E_we;
    reg [3:0] E_opcode;
    reg [2:0] E_dest, E_s1_addr, E_s2_addr; 
    reg [7:0] E_s1, E_s2, E_result;
    
    //write back
    reg W_we;
    reg [2:0] W_dest;
    reg [7:0] W_result;
    
    //local registers and wires
    reg [7:0] data_reg;
    wire [7:0] data;
    wire [3:0] opcode;
    wire [2:0] dest_addr, s1_addr, s2_addr;
    
    wire [7:0] pc, s1, s2, alu_result;
    wire [15:0] instruction;
    wire mode, res_we, mem_wr;
    
    PC programCounter (.clk(clk), .rst(rst), .new_addr(8'b0), .load(1'b0), .pc(pc));
    
    ROM IM (.clk(clk), .addr(pc), .we(we), .data_in(8'b0), .instruction(instruction));
    
    always @(posedge clk) begin
       // fetch to decode state registers
       IFD_instruction <= instruction;
       
       //decode to execute state registers
       IDE_opcode <= opcode;
       IDE_dest_addr <= dest_addr; 
       IDE_s1_addr <= s1_addr;
       IDE_s2_addr <= s2_addr;
       IDE_mode <= mode;
       IDE_s1 <= s1;
       IDE_s2 <= s2;
       IDE_mem_wr <= mem_wr;
       IDE_res_we <= res_we;
       IDE_data <= data;
       
       //execute state registers
       E_opcode <= IDE_opcode;
       E_dest <= IDE_dest_addr;
       E_s1_addr  <= IDE_s1_addr;
       E_s2_addr  <= IDE_s2_addr;
       E_s1 <= IDE_s1;
       E_s2 <= IDE_s2;
       E_we <= res_we | mem_wr | 1'b0;
       if(mem_wr == 1'b1) E_result <= IDE_data;
       
       //write back state registers
       W_we <= E_we;
       W_dest <= E_dest;
       W_result <= E_result;
    end
    
    always @(*) begin
        if(IDE_res_we == 1'b1) E_result <= alu_result;
    end
       
    InstructionDecoder ID (
        .clk(clk), 
        .instruction(IFD_instruction), 
        .opcode(opcode), 
        .dest(dest_addr), 
        .src1(s1_addr), 
        .src2(s2_addr), 
        .data(data), 
        .mode(mode)
    );
    
    ControlUnit CU (
        .opcode(IDE_opcode),
        .mode(IDE_mode), 
        .clk(clk),
        .res_we(res_we),
        .mem_wr(mem_wr)
    );
    
    RegisterFile RF(
        .clk(clk),
        .we(IDE_mem_wr | IDE_res_we),
        .write_data(E_result),
        .dest_addr(E_dest),
        .s1_addr(E_s1_addr),
        .s2_addr(E_s2_addr),
        .s1(s1),
        .s2(s2)
    );
    
    ALU alu(
        .clk(clk),
        .rst(rst),
        .a(s1),
        .b(s2),
        .opcode(E_opcode),
        .result(alu_result)
    );
endmodule