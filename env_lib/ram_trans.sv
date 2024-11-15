class ram_trans;
   rand bit[63:0] data;
   rand bit[11:0] rd_address;
   rand bit[11:0] wr_address;
   rand bit       read;
   rand bit       write;
   logic [63:0] data_out;
 
   // to keep the count of transactions generated
   static int trans_id;

   static int no_of_read_trans;
   static int no_of_write_trans;
   static int no_of_RW_trans;
  
   constraint VALID_ADDR {wr_address != rd_address;}
   constraint VALID_CTRL {{read,write} != 2'b00;}
   constraint VALID_DATA {data inside {[1:4294]};}

   function void post_randomize();
      trans_id++;
      if(this.read==1 && this.write==0)
         no_of_read_trans++;
      if(this.write==1 && this.read==0)
         no_of_write_trans++;
      if(this.read==1 && this.write==1)
         no_of_RW_trans++;
      this.display("\tRANDOMIZED DATA");
   endfunction: post_randomize

   virtual function void display(input string message);
      $display("=============================================================");
      $display("%s",message);
      if(message=="\tRANDOMIZED DATA")
         begin
            $display("\t_______________________________");
            $display("\tTransaction No. %d",trans_id);
            $display("\tRead Transaction No. %d", no_of_read_trans);
            $display("\tWrite Transaction No. %d", no_of_write_trans);
            $display("\tRead-Write Transaction No. %d", no_of_RW_trans);
            $display("\t_______________________________");
         end
      $display("\tRead=%d, write=%d",read,write);
      $display("\tRead_Address=%d, Write_Address=%d",rd_address, wr_address);
      $display("\tData=%d",data);
      $display("\tData_out= %d",data_out);
      $display("=============================================================");
   endfunction: display

   virtual function bit compare (input ram_trans rcvd,output string message);
      compare='0;
      begin
         if(this.rd_address != rcvd.rd_address)
            begin
               $display($time);
               message ="--------- ADDRESS MISMATCH ---------";
               return(0);
            end
        
         if(this.data_out != rcvd.data_out)
            begin
               $display($time);
               message="--------- DATA MISMATCH ---------";
               return(0);
            end
     
            begin
               message=" SUCCESSFULLY COMPARED";
               return(1);
            end
      end
   endfunction: compare

endclass: ram_trans
