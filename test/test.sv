class test;
   virtual ram_if.RD_DRV_MP rd_drv_if;
   virtual ram_if.WR_DRV_MP wr_drv_if; 
   virtual ram_if.RD_MON_MP rd_mon_if; 
   virtual ram_if.WR_MON_MP wr_mon_if;
   
   ram_env env_h;
     
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      this.wr_drv_if = wr_drv_if;
      this.rd_drv_if = rd_drv_if;
      this.wr_mon_if = wr_mon_if;
      this.rd_mon_if = rd_mon_if;
      
      env_h = new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);
   endfunction: new

   virtual task build();
      env_h.build();
   endtask: build
   
   virtual task run();              
      env_h.run();
   endtask: run  
endclass: test
