// parameters
`define ADDR_WIDTH 4
`define DATA_WIDTH 32
`define NUM_TRANSACTION 10

// typedefs
typedef enum {IDLE, SETUP, ACCESS} op_state;