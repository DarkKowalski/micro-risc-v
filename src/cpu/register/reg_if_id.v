`include "../defines.v"

module reg_if_id(
    input wire clk,
    input wire rst,

    input wire[`InstAddrBus] if_pc,
    input wire[`InsBus] if_inst,

    output reg[`InstAddrBus] id_pc,
    output reg[`InsBus] id_inst
);

    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            id_pc <= `ZeroWord;
            id_inst <= `ZeroWord;
        end else begin
            id_pc <= if_pc;
            id_inst <= if_inst;
        end
    end

endmodule