`include "../defines.v"

module regfile(
    input wire clk,
    input wire rst,

    // Wirte
    input wire we,
    input wire[`RegAddrBus] waddr,
    input wire[`RegBus] wdata,

    // Read
    input wire re1,
    input wire[`RegAddrBus] raddr1,
    output reg[`RegBus] rdata1,

    input wire re2,
    input wire[`RegAddrBus] raddr2,
    output reg[`RegBus] rdata2
);

    reg[`RegBus] regs[0:`RegNum - 1];

// Write
    always @ (posedge clk) begin
        if (rst == `RstDisable) begin
        /*
        The zero register is a special register that is hard-wired to 
        the integer value 0. This register is found in many RISC instruction 
        set architectures such as MIPS and RISC-V. On those architectures writing 
        to that register is always discarded and reading its value will always 
        result in a 0 being read.
        */
            if ((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
                regs[waddr] <= wdata;
        end
    end

// Read
    always @ (*) begin
        if (rst == `RstEnable) begin
            rdata1 <= `ZeroWord;
        end else if (raddr1 == `RegNumLog2'h0) begin
            rdata1 <= `ZeroWord;
        end else if ((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable)) begin
            rdata1 <= wdata;
        end else if (re1 == `ReadEnable) begin
            rdata1 <= regs[raddr1];
        end else begin
            rdata1 <= `ZeroWord;
        end
    end

    always @ (*) begin
        if (rst == `RstEnable) begin
            rdata2 <= `ZeroWord;
        end else if (raddr2 == `RegNumLog2'h0) begin
            rdata2 <= `ZeroWord;
        end else if ((raddr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable)) begin
            rdata2 <= wdata;
        end else if (re2 == `ReadEnable) begin
            rdata2 <= regs[raddr2];
        end else begin
            rdata2 <= `ZeroWord;
        end
    end

endmodule