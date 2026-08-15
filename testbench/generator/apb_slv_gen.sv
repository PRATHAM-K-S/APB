class apb_slv_gen;

    // Transaction handle decleration
    apb_slv_trans tx_h;

    // Mailbox declerations
    mailbox #(apb_slv_trans) mbx_gen_drv;

    // Class constructor
    function new(mailbox #(apb_slv_trans) mbx);
        mbx_gen_drv = mbx;
        tx_h = new();    
    endfunction

    // Run
    task run();
        repeat(`NUM_TRANSACTION) begin
            if(!tx_h.randomize())
                $error("[RUN]: Randomization Failed");
            else begin
                mbx_gen_drv.put(tx_h.copy());
                tx_h.print();
            end
        end
    endtask 
    
endclass //apb_slv_gen