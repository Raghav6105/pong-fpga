module debounce(
    input wire clk,
    input wire btn,
    output reg btn_db = 0
);

reg [15:0] count = 0;

always @(posedge clk)
begin
    
    if (btn != btn_db) begin 
        count <= count + 1;
        
        if (count == 16'hFFFF) begin
            btn_db <= btn;
            count <= 0;
        end
    end else begin
        count <= 0;
    end
end

endmodule

//changed the whole code