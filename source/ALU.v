module ALU (
    input clk, rst,
    input [7:0] a, b,
    input [3:0] opcode,
    output reg [7:0] result
);    
   reg [8:0] temp_res;
   wire [2:0] flag_index;
   wire flag_out;
   
   reg carry, zero;
   
   FlagRegister FR(
    .clk(clk), 
    .rst(rst), 
    .flag_index(flag_index), 
    .flag_out(flag_out),
    .we(1'b1),
    .carry(carry),
    .zero(zero)
   );
   
    always @(*) begin
        case (opcode)
            4'b0000: temp_res <= a + b;
            4'b0001: temp_res <= a - b;
            4'b0010: temp_res <= a * b;
            4'b0011: temp_res <= a / b;
            4'b0100: temp_res <= a & b;
            4'b0101: temp_res <= a | b;
            4'b0110: temp_res <= ~a;
        endcase
        
        result <= temp_res[7:0];
    end
    
    always @(*) begin
        carry <= temp_res[8];
        zero <= (result == 8'b0);
    end
endmodule