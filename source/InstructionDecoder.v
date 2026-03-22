module InstructionDecoder(
    input clk,
    input [15:0] instruction,
    output reg [3:0] opcode,
    output reg [2:0] dest,
    output reg [2:0] src1,
    output reg [2:0] src2,
    output reg [7:0] data,
    output reg mode
    );
    
    always @(*) begin
        mode <= 1'b0;
        opcode <= instruction[15:12];
        dest <= instruction[11:9];
    
        if(instruction[0] == 1'b0) begin
            mode <= 1'b0;
            src1 <= instruction[8:6];
            src2 <= instruction[5:3];
            data <= 8'b0;
        end
        else begin
            mode <= 1'b1;
            src1 <= 3'b000;
            src2 <= 3'b000;
            data <= instruction[8:1];
        end
    end
endmodule