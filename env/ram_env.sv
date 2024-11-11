class ram_env;
   virtual ram_if.WR_DRV_MP wr_drv_if;
   virtual ram_if.RD_DRV_MP rd_drv_if;
   virtual ram_if.WR_MON_MP wr_mon_if;
   virtual ram_if.RD_MON_MP rd_mon_if; 
                                                                           
   mailbox #(ram_trans) gen2wr = new();
   mailbox #(ram_trans) gen2rd = new();

   mailbox #(ram_trans) wr2rm  = new();
   mailbox #(ram_trans) rd2rm  = new();

   mailbox #(ram_trans) rd2sb  = new();
   
   ram_gen        gen_h;
   ram_write_drv  wr_drv_h;
   ram_read_drv   rd_drv_h;
   ram_write_mon  wr_mon_h;
   ram_read_mon   rd_mon_h;
      
   function new(virtual ram_if.WR_DRV_MP wr_drv_if,
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      this.wr_drv_if = wr_drv_if;
      this.rd_drv_if = rd_drv_if;
      this.wr_mon_if = wr_mon_if;
      this.rd_mon_if = rd_mon_if;
   endfunction: new
   
   virtual task build;
      gen_h      = new(gen2rd, gen2wr);
      wr_drv_h   = new(wr_drv_if,gen2wr);
      rd_drv_h   = new(rd_drv_if, gen2rd);
      wr_mon_h   = new(wr_mon_if,wr2rm);
      rd_mon_h   = new(rd_mon_if,rd2rm,rd2sb);
   endtask: build

   virtual task reset_dut();
      begin
         rd_drv_if.rd_drv_cb.rd_address<='0;
         rd_drv_if.rd_drv_cb.read<='0;

         wr_drv_if.wr_drv_cb.wr_address<=0;
         wr_drv_if.wr_drv_cb.write<='0;

         repeat(5) @(wr_drv_if.wr_drv_cb);
         for (int i=0; i<4096; i++)
            begin
               wr_drv_if.wr_drv_cb.write<='1;
               wr_drv_if.wr_drv_cb.wr_address<=i;
               wr_drv_if.wr_drv_cb.data_in<='0;
               @(wr_drv_if.wr_drv_cb);
            end
         wr_drv_if.wr_drv_cb.write<='0;
         repeat (5) @(wr_drv_if.wr_drv_cb);
      end
   endtask: reset_dut

   virtual task start;
      gen_h.start();
      wr_drv_h.start();
      rd_drv_h.start();
      wr_mon_h.start();
      rd_mon_h.start();
   endtask: start

   virtual task stop();
      #1000;
   endtask: stop 

   virtual task run();
      reset_dut();
      start();
      stop();
   endtask: run
endclass: ram_env
