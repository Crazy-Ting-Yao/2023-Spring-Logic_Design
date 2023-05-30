module Traffic_Light_Controller(CLK, RESET, LR_has_Car, HW_light, LR_light);
    input CLK, RESET, LR_has_Car;
    output reg [2:0] HW_light, LR_light;
    integer i;
    reg flag;
    initial begin
        HW_light = 3'b100;
        LR_light = 3'b001;
        flag = 1;
        i = 5;
    end
    always@(posedge CLK && !RESET)begin
        if(i == 0) begin
            case(HW_light)
                3'b100:begin
                    if(LR_has_Car) begin
                        HW_light <= 3'b010;
                        i = 2;
                    end
                end
                3'b010:begin
                    HW_light <= 3'b001;
                end
                3'b001:begin
                    if(LR_has_Car && flag) begin
                        case(LR_light)
                        3'b001:begin
                            LR_light <= 3'b100;
                            i = 4;
                        end
                        3'b010:begin
                            LR_light <= 3'b001;
                            flag = 0;
                        end
                        3'b100:begin
                            LR_light <= 3'b010;
                            i = 2;
                        end
                        default:begin
                            HW_light <= 3'b100;
                            LR_light <= 3'b001;
                            i = 4;
                        end
                        endcase
                    end
                    else if(flag==1'b0) begin
                        HW_light <= 3'b100;
                        i = 4;
                        flag = 1;
                    end
                end
                default:begin
                    HW_light <= 3'b100;
                end
            endcase
        end
        else i = i - 1;
    end
    always@(*) begin
        if(RESET) begin
            HW_light = 3'b100;
            LR_light = 3'b001;
            i = 5;
        end
    end
endmodule

module lab3_tb2;
    reg CLK, RESET, LR_has_Car;
    wire [2:0] HW_light, LR_light;
    parameter delay = 5;
    integer i;
    Traffic_Light_Controller TLC_Lab3(CLK, RESET, LR_has_Car, HW_light, LR_light);
    reg [19:0] LR_pattern = 20'b11111100111111100000;
    initial begin
        $dumpfile("lab3_tb2.vcd");
        $dumpvars(0, lab3_tb2);
        CLK = 0;
        RESET = 1;
        LR_has_Car = 0;
        #delay CLK = ~CLK;
        #delay CLK = ~CLK;
        RESET = 0;
        for(i = 0; i < 20; i = i + 1)begin
            LR_has_Car = LR_pattern[i];
            #delay CLK = ~CLK;
            #delay CLK = ~CLK;
        end
        $finish;
    end
endmodule

         