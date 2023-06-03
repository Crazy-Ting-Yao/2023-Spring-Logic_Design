module PAT(clk, reset, data, flag);
    input clk, reset, data;
    output reg flag;
    reg [2:0] state;
    reg [2:0] next_state;
    initial begin
        state = 3'b000;
        next_state = 3'b000;
    end
    always@(posedge clk)begin
        if(reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always@(*)begin
        if(reset) begin
            next_state = 3'b000;
            flag = 1'b0;
        end
        else begin
        case(state)
            3'b000:begin
                if(data)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
            end
            3'b001:begin
                if(data)
                    next_state = 3'b011;
                else
                    next_state = 3'b010;
            end
            3'b010:begin
                if(data)
                    next_state = 3'b101;
                else
                    next_state = 3'b000;
            end
            3'b011:begin
                if(data)
                    next_state = 3'b011;
                else
                    next_state = 3'b110;
            end
            3'b101:begin
                if(data)
                    next_state = 3'b011;
                else
                    next_state = 3'b010;
            end
            3'b110:begin
                if(data)
                    next_state = 3'b101;
                else
                    next_state = 3'b000;
            end
            default:begin
                next_state = 3'b000;
            end
        endcase
        end
    end

    always@(posedge clk)begin
        if(reset)
            flag = 1'b0;
        else begin
            case(state)
                3'b110:begin
                    if(data)
                        flag = 1'b1;
                    else
                        flag = 1'b0;
                end
                3'b101:begin
                    if(data)
                        flag = 1'b1;
                    else
                        flag = 1'b0;
                end
                default:begin
                    flag = 1'b0;
                end
            endcase
        end
    end
endmodule


module Traffic_Light_Controller(CLK, RESET, LR_has_Car, HW_light, LR_light);
    input CLK, RESET, LR_has_Car;
    output reg [2:0] HW_light, LR_light;
    integer i;
    reg [2:0] state;
    initial begin
        state = 3'b000;
        i = 5;
    end
    always@(*) begin
        if(RESET) begin
            state = 3'b000;
            HW_light = 3'b100;
            LR_light = 3'b001;
            i = 5;
        end
        else begin
            case(state)
                3'b000: begin
                    HW_light = 3'b100;
                    LR_light = 3'b001;
                end
                3'b001: begin
                    HW_light = 3'b010;
                    LR_light = 3'b001;
                end
                3'b010: begin
                    HW_light = 3'b001;
                    LR_light = 3'b001;
                end
                3'b100: begin
                    HW_light = 3'b001;
                    LR_light = 3'b100;
                end
                3'b101: begin
                    HW_light = 3'b001;
                    LR_light = 3'b010;
                end
                3'b110: begin
                    HW_light = 3'b001;
                    LR_light = 3'b001;
                end
            endcase
        end
    end
    always@(posedge CLK && !RESET)begin
        if(i == 0) begin
            case(state)
                3'b000:begin
                    if(LR_has_Car) begin
                        state <= 3'b001;
                        i = 2;
                    end
                end
                3'b001:begin
                    state <= 3'b010;
                end
                3'b010:begin
                    state <= 3'b100;
                    i = 4;
                end
                3'b100:begin
                    state <= 3'b101;
                    i = 2;
                end
                3'b101:begin
                    state <= 3'b110;
                end
                3'b110:begin
                    state <= 3'b000;
                    i = 4;
                end
                default:begin
                    state <= 3'b000;
                    i = 4;
                end
            endcase
        end
        else i = i - 1;
    end
endmodule
