module ControlUnit(
    input [3:0] opcode,
    input mode, clk,
    output reg res_we, rd, mem_wr
);
    always @(*) begin
        res_we <= 1'b0;
        mem_wr <= 1'b0;
        case (opcode)
            4'b0000, 4'b0001, 4'b0010, 4'b0011,
            4'b0100, 4'b0101, 4'b0110, 4'b0111,
            4'b1000, 4'b1001, 4'b1010: begin
                if(mode == 1'b0) begin
                    res_we <= 1'b1;
                    rd <= 1'b1;
                end
                else if(mode == 1'b1) begin
                    res_we <= 1'b1;
                    rd <= 1'b1;
                end
            end
            4'b1100: begin
                if(mode == 1'b1) begin
                    res_we <= 1'b0;
                    rd <= 1'b0;
                    mem_wr <= 1'b1;
                end
            end
            default: begin
                res_we <= 1'b0;
                mem_wr <= 1'b0;
                rd <= 1'b0;
            end
        endcase
    end
endmodule