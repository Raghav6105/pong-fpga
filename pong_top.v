module pong_top(
    input wire clk,
    input wire reset,

    input wire btn1_up,
    input wire btn1_down,
    input wire btn2_up,
    input wire btn2_down,

    output wire hsync,
    output wire vsync,
    output wire [2:0] rgb,

    output wire [6:0] seg1,
    output wire [6:0] seg2,
	 
    output wire vga_clk,
    output wire vga_blank_n,
    output wire vga_sync_n
);

wire clk25;

wire video_on;
wire [9:0] pixel_x;
wire [9:0] pixel_y;

wire [2:0] rgb_next;
reg [2:0] rgb_reg;

wire [3:0] score1;
wire [3:0] score2;


wire db_btn1_up, db_btn1_down, db_btn2_up, db_btn2_down;

debounce db1(.clk(clk25), .btn(~btn1_up), .btn_db(db_btn1_up));
debounce db2(.clk(clk25), .btn(~btn1_down), .btn_db(db_btn1_down));
debounce db3(.clk(clk25), .btn(~btn2_up), .btn_db(db_btn2_up));
debounce db4(.clk(clk25), .btn(~btn2_down), .btn_db(db_btn2_down));

clock_div clk_divider(
    .clk(clk),
    .clk25(clk25)
);

vga_sync vga_unit(
    .clk(clk25),
    .reset(~reset), 
    .hsync(hsync),
    .vsync(vsync),
    .video_on(video_on),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y)
);

pong_graph pong_unit(
    .clk(clk25),
    .video_on(video_on),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y),

  
    .btn1_up(db_btn1_up),
    .btn1_down(db_btn1_down),
    .btn2_up(db_btn2_up),
    .btn2_down(db_btn2_down),

    .rgb_next(rgb_next),
    .score1(score1),
    .score2(score2)
);



seven_seg disp1(
    .score(score1),
    .seg(seg1)
);

seven_seg disp2(
    .score(score2),
    .seg(seg2)
);

always @(posedge clk25)
    rgb_reg <= rgb_next;

assign rgb = rgb_reg;

assign vga_clk = clk25;           
assign vga_blank_n = video_on;    
assign vga_sync_n = 1'b0;         

endmodule