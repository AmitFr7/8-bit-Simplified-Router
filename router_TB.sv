`timescale 1ns / 1ps


module Router_TB();
  
  reg [1:0] port;
  reg [1:0] p;
  reg [7:0] Address;
  reg setup, reset, clk;
  
  router router_DUT(.Port(port),
                    .p(p),
                    .Address(Address),
                    .setup(setup), .reset(reset), .clk(clk));
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  initial begin
    clk=0;
    forever
      #5 clk = ~clk;
  end
  	
 initial begin
    reset=0; setup=1; //fill the routing table:
   
    Address = 8'b0010_1010; p = 2'b10; #10
    Address = 8'b1101_1100; p = 2'b00; #10
    Address = 8'b1111_1001; p = 2'b01; #10
    Address = 8'b0010_1001; p = 2'b01; #10
    Address = 8'b1100_0110; p = 2'b10; #10
    Address = 8'b1101_1011; p = 2'b11; #10
    Address = 8'b1001_0011; p = 2'b00; #10
    Address = 8'b1010_1010; p = 2'b10; #11
    setup = 0; //begin routing:
   
   	Address = 8'hdb; #10
    Address = 8'h77; #13
    Address = 8'hc6; #17
    reset = 1'b1; #20
    $finish;    
  	end

endmodule
