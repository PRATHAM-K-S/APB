interface apb_slv_if (bit PCLK, bit PRESETn);

    // Input ports
    logic [`ADDR_WIDTH-1:0] PADDR;
    logic PSEL;
    logic PENABLE;
    logic PWRITE;
    logic [`DATA_WIDTH-1:0] PWDATA;
    logic [(`DATA_WIDTH/8)-1:0] PSTRB;

    // Output ports
    logic [`DATA_WIDTH-1:0] PRDATA;
    logic PREADY;
    logic PSLVERR;

    // Driver clocking block
    clocking drv_cb @(posedge PCLK);
        default output #1;
        output PADDR;
        output PSEL;
        output PENABLE;
        output PWRITE;
        output PWDATA;
        output PSTRB;
    endclocking

    // Monitor clocking block
    clocking mon_cb @(posedge PCLK);
        default input #1;
        input PADDR;
        input PSEL;
        input PENABLE;
        input PWRITE;
        input PWDATA;
        input PSTRB;
        input PRDATA;
        input PREADY;
        input PSLVERR;
    endclocking

    // Modports
    modport DRV(clocking drv_cb, input PRESETn);
    modport MON(clocking mon_cb, input PRESETn);
    
endinterface //apb_slv_if (bit clk, bit rst)