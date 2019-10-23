`include "../defines.v"

module stage_id(
    input wire               rst,
    input wire[`InstAddrBus] pc_i,
    input wire[`InstBus]     inst_i,

    // Read regfile
    input wire[`RegBus]      reg1_data_i,
    input wire[`RegBus]      reg2_data_i,

    // Output to regfile
    output reg               reg1_read_o,
    output reg               reg2_read_o,
    output reg[`RegAddrBus]  reg1_addr_o,
    output reg[`RegAddrBus]  reg2_addr_o,

    // Output to EX
    output reg[`AluOpBus]    aluop_o,
    output reg[`AluSelBus]   alusel_o,
    output reg[`RegBus]      reg1_o,
    output reg[`RegBus]      reg2_o,
    output reg[`RegAddrBus]  wd_o,
    output reg               wreg_o,
);

    // Details at riscv-spec page 128
    wire[6:0] opcode = inst_i[6:0];
    wire[2:0] funct3 = inst_i[14:12];
    wire[6:0] funct7 = inst_i[31:25];

    wire[11:0] I_imm = inst_i[31:25];
    wire[11:0] S_imm = {inst_i[31:25], inst_i[11:7]};
    wire[19:0] U_imm = inst_i[31:12];
    
    wire[`RegAddrBus] rd = inst_i[11:7];
    wire[`RegAddrBus] rs1 = inst_i[19:15];
    wire[`RegAddrBus] rs2 = inst_i[24:20];

    reg[`RegBus] imm1;
    reg[`RegBus] imm2;

    reg instvalid;

    // Decode

    always @ (*) begin
        if (rst == `RstEnable) begin
            aluop_o <= `EXE_NOP_OP;
            alusel_o <= `EXE_RES_NOP;
            wd_o <= `NOPRegAddr;
            wreg_o <= `WriteDisable;
            instvalid <= `InstInvalid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= `NOPRegAddr;
            reg2_addr_o <= `NOPRegAddr;
            imm1 <= `ZeroWord;
            imm2 <= `ZeroWord;
        end else begin
            alusel_o <= `EXE_NOP_OP;
            alusel_o <= `EXE_RES_NOP;
            wd_o <= rd;
            wreg_o <= `WriteDisable;
            instvalid <= `InstInvalid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= rs1;
            reg2_addr_o <= rs2;
            imm1 <= `ZeroWord;
            imm2 <= `ZeroWord;

            case (opcode)
                // Some opcodes
                // begin
                // TODO: decode
                // end
            endcase
        end
    end
