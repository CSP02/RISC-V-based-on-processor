module RegisterFile (
    input clk, we,
    input [2:0] dest_addr, s1_addr, s2_addr,
    input [7:0] write_data, 
    output [7:0] s1, s2 
);
    reg [7:0] registers [7:0];     
    integer i;  
    initial begin
        for (i = 0; i < 8; i = i + 1)
            registers[i] = 0;
    end

    always @(posedge clk) begin
        if (we) registers[dest_addr] <= write_data;
    end

//    always @(*) begin
        assign s1 = registers[s1_addr];
        assign s2 = registers[s2_addr];
//    end
endmodule