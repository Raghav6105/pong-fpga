module pong_graph(

    input wire clk,
    input wire video_on,

    input wire [9:0] pixel_x,
    input wire [9:0] pixel_y,

    input wire btn1_up,
    input wire btn1_down,
    input wire btn2_up,
    input wire btn2_down,

    output reg [2:0] rgb_next,

    output reg [3:0] score1 = 0,
    output reg [3:0] score2 = 0
);

reg [9:0] paddle1_y = 200;
reg [9:0] paddle2_y = 200;

reg [9:0] ball_x = 320;
reg [9:0] ball_y = 240;

reg ball_dx = 1;
reg ball_dy = 1;

always @(posedge clk)
begin //changed
    if (pixel_x == 0 && pixel_y == 480) 
    begin
        if(btn1_up && paddle1_y > 0)
            paddle1_y <= paddle1_y - 2;
        
        if(btn1_down && paddle1_y < 440)
            paddle1_y <= paddle1_y + 2;
            
        if(btn2_up && paddle2_y > 0)
            paddle2_y <= paddle2_y - 2;
            
        if(btn2_down && paddle2_y < 440)
            paddle2_y <= paddle2_y + 2;

        ball_x <= ball_dx ? ball_x + 1 : ball_x - 1;
        ball_y <= ball_dy ? ball_y + 1 : ball_y - 1;

        if(ball_y == 0 || ball_y == 479)
            ball_dy <= ~ball_dy;

        if(ball_x <= 20 && ball_y > paddle1_y && ball_y < paddle1_y+40)
            ball_dx <= 1;

        if(ball_x >= 620 && ball_y > paddle2_y && ball_y < paddle2_y+40)
            ball_dx <= 0;

        if(ball_x == 0)
        begin
            score2 <= score2 + 1;
            ball_x <= 320;
            ball_y <= 240;
        end

        if(ball_x == 639)
        begin
            score1 <= score1 + 1;
            ball_x <= 320;
            ball_y <= 240;
        end
    end
end


always @*
begin

rgb_next = 3'b000;

if(video_on)
begin

    if(pixel_x < 10 && pixel_y > paddle1_y && pixel_y < paddle1_y+40)
        rgb_next = 3'b010;

    else if(pixel_x > 630 && pixel_y > paddle2_y && pixel_y < paddle2_y+40)
        rgb_next = 3'b010;

    else if(pixel_x > ball_x && pixel_x < ball_x+8 &&
            pixel_y > ball_y && pixel_y < ball_y+8)
        rgb_next = 3'b111;

end

end

endmodule