`include "../defines.v"

module reg_pc(
    input wire               clk,
    input wire               rst,
    output reg[`InstAddrBus] pc,
    output reg               ce
)

    always @ (posedge clk) begin
        if (rst == `RstEnabel) begin
            ce <= `ChipDisable
        end else begin
            ce <= `ChipEnable
        end
    end

    always @ (posedge clk) begin
        if (ce == `ChipDisable) begin
            pc <= `ZeroWord
        end else begin
            pc <= pc + 4'h4 // pc increases 4 per cycle
        end
    end

endmodule