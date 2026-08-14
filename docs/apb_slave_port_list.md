
Port List for the RTL Slave design:

| Port    | Direction | Width        | Description                                                                                                                                                  |
| ------- | --------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| PCLK    | Input     | 1            | APB interface clock. All slave operations are synchronized to its rising edge.                                                                               |
| PRESETn | Input     | 1            | Active-low asynchronous reset. Clears the memory contents and resets the read data output.                                                                   |
| PADDR   | Input     | ADDR_WIDTH   | Address supplied by the APB master. Used to select the target memory location for read or write operations.                                                  |
| PSEL    | Input     | 1            | Slave select signal. Indicates that the slave is selected for an APB transaction.                                                                            |
| PENABLE | Input     | 1            | Indicates the ACCESS phase of an APB transaction. Used together with PSEL to qualify a valid transfer.                                                       |
| PWRITE  | Input     | 1            | Transfer direction control. 1 indicates a write transaction, 0 indicates a read transaction.                                                                 |
| PWDATA  | Input     | DATA_WIDTH   | Write data supplied by the master during write transactions.                                                                                                 |
| PSTRB   | Input     | DATA_WIDTH/8 | Byte-enable strobes for write transactions. Each asserted bit enables writing to its corresponding byte lane.                                                |
| PRDATA  | Output    | DATA_WIDTH   | Read data returned to the master during read transactions.                                                                                                   |
| PREADY  | Output    | 1            | Ready signal indicating completion of the current transfer. This implementation is always ready (1), resulting in single-cycle accesses with no wait states. |
| PSLVERR | Output    | 1            | Indicates an APB error. Asserted when a valid transfer attempts to access an address outside the implemented memory range.                                   |
