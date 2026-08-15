class apb_slv_trans;

    // Input signals
    rand bit [`ADDR_WIDTH-1:0] PADDR;
    rand bit PSEL;
    rand bit PENABLE;
    rand bit PWRITE;
    rand bit [`DATA_WIDTH-1:0] PWDATA;
    rand bit [(`DATA_WIDTH/8)-1:0] PSTRB;

    // Output signals
    logic [`DATA_WIDTH-1:0] PRDATA;
    logic PREADY;
    logic PSLVERR;

	// randomization variables
	local rand op_state next_state;

	// latch signals
	local bit [`ADDR_WIDTH-1:0] prev_addr;
	local bit prev_pwrite;
	local bit [`DATA_WIDTH-1:0] prev_pwdata;
	local bit [`STRB_WIDTH-1:0] prev_pstrb;

    // Initializatons
	op_state current_state = IDLE;

    // APB protocol based transaction generator constraint
	constraint master{
		if(current_state == IDLE) {
			PSEL == 0;
			PENABLE == 0;
			next_state inside {IDLE, SETUP};
		}
		else if(current_state == SETUP) {
			PSEL == 1;
			PENABLE == 0;
			next_state == ACCESS;
		}
		else if(current_state == ACCESS) {
			PSEL == 1;
			PENABLE == 1;
			PADDR == prev_addr;
			PWRITE == prev_pwrite;
			PWDATA == prev_pwdata;
			PSTRB == prev_pstrb;
			next_state inside {IDLE,SETUP};
		}
	}

    constraint pwrite_dist {
		PWRITE dist {0:=3, 1:=7};
	}

	function void post_randomize();
		prev_addr = PADDR;
		prev_pwrite = PWRITE;
		prev_pwdata = PWDATA;
		prev_pstrb = PSTRB;
		current_state = next_state;
	endfunction

	// object copy function
	function apb_slave_transaction copy();
		copy = new;
		copy.PADDR = this.PADDR;
		copy.PWRITE = this.PWRITE;
		copy.PWDATA = this.PWDATA;
		copy.PSTRB = this.PSTRB;
		copy.PSEL = this.PSEL;
		copy.PENABLE = this.PENABLE;
		copy.PRDATA = this.PRDATA;
		copy.PREADY = this.PREADY;
		copy.SLVERR = this.SLVERR;
	endfunction

    // Print signals
    function void print();
        $display("PADDR: \t%0d\n PSEL: \t%b\n PENABLE: \t%0b\n PWRITE: \t%0b\n PWDATA: \t%0d\n PSTRB: \t%0b\n PRDATA: \t%0d\n PREADY: \t%0b\n PSLVERR: \t%0b\n",
        PADDR, PSEL, PENABLE, PWRITE, PWDATA, PSTRB, PRDATA, PREADY, PSLVERR);
    endfunction

endclass //apb_slv_trans