module PC(
    input rst, clk,
    input [7:0] new_addr,
    input load,
    output reg [7:0] pc
);

    initial begin
        pc <= 8'b0;
    end
    
    always @(posedge clk) begin
        if(rst) pc <= 8'b0;
        else if (load) pc <= new_addr;
        else pc <= pc + 1; 
    end
endmodule