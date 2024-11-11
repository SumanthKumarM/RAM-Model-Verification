package ram_pkg;

   int number_of_transactions=1;

   `include "ram_trans.sv"
   `include "ram_gen.sv"
   `include "write_drv.sv"
   `include "read_drv.sv"
   `include "write_mon.sv"
   `include "read_mon.sv"
   `include "ram_env.sv"
   `include "test.sv"

endpackage
