module FlagRegister(
    input [2:0] flag_index,
    output reg flag_out,
    input zero, carry, clk, rst, we
    );
    
    reg [7:0] flag_register;
    always @(posedge clk or posedge rst) begin
        if(rst == 1'b1) flag_register <= 8'b0;
        else if(we == 1'b1) begin
            flag_register[0] <= zero;
            flag_register[1] <= carry;
        end
    end
    
    always @(*) begin
        flag_out <= flag_register[flag_index];
    end
endmodule