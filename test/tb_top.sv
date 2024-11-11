module top();
   import ram_pkg::*;  
  
   parameter cycle = 10;
   reg clock;
   ram_if DUV_IF(clock);

   test test_h;
  
   ram_4096 RAM ( .clk        (clock),
                  .data_in    (DUV_IF.data_in),
                  .data_out   (DUV_IF.data_out),
                  .wr_address (DUV_IF.wr_address),
                  .rd_address (DUV_IF.rd_address),
                  .read       (DUV_IF.read),
                  .write      (DUV_IF.write)
                ); 
   
   initial
      begin
         clock = 1'b0;
         forever #(cycle/2) clock=~clock;
      end

   initial
	begin
	 
	`ifdef VCS
         $fsdbDumpvars(0, top);
        `endif
         test_h = new(DUV_IF,DUV_IF, DUV_IF, DUV_IF);
         number_of_transactions = 10;
         test_h.build();
         test_h.run();
         $finish;
      end
endmodule
