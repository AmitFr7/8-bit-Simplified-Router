`timescale 1ns / 1ps


module router
  (output reg [1:0] Port,
   input wire [1:0] p,				
   input wire [7:0] Address,
   input wire setup, reset, clk);
  
  wire found;
  wire [2:0] index;
  
  // the routing table consists of the address and port columns: 
  
  Addresses address_column 	(.found(found), .index(index),
                             .address_in(Address),
                            .setup(setup), .reset(reset), .clk(clk));
  
  Ports 	port_column 	(.port_out(Port),
                             .port_index(index), .p(p), .found(found),
                             .setup(setup), .reset(reset), .clk(clk)); 
  
endmodule

// the address column (8-bit shift register):

module Addresses
  (output reg found,
   output reg [2:0] index,
   input wire [7:0] address_in,
   input wire setup, reset, clk
   );
  
  reg [7:0] address [7:0];
      
  always @(posedge clk, posedge reset)
    begin
      if (reset) // asynchronous active HIGH reset
        begin
          address[0] <= 8'h00;
          address[0] <= 8'h00;
          address[2] <= 8'h00;
          address[3] <= 8'h00;
          address[4] <= 8'h00;
          address[5] <= 8'h00;
          address[6] <= 8'h00;
          address[7] <= 8'h00;
        end
      else if (setup == 1) //on the first phase (setup), fill the address column
        begin
          address[0] <= address_in;
          address[1] <= address[0];
          address[2] <= address[1];
          address[3] <= address[2];
          address[4] <= address[3];
          address[5] <= address[4];
          address[6] <= address[5];
          address[7] <= address[6];
        end
      else //setup 0, search for the input address
        case (address_in)
          address[0] : begin index <= 3'b000; found <= 1; end
          address[1] : begin index <= 3'b001; found <= 1; end
          address[2] : begin index <= 3'b010; found <= 1; end
          address[3] : begin index <= 3'b011; found <= 1; end
          address[4] : begin index <= 3'b100; found <= 1; end
          address[5] : begin index <= 3'b101; found <= 1; end
          address[6] : begin index <= 3'b110; found <= 1; end
          address[7] : begin index <= 3'b111; found <= 1; end
          default    : begin index <= 3'b000; found <= 0; end
        endcase
    end
          
endmodule
          
// the address column (2-bit shift register, 4 possiblem ports):
// (default port is 00) 

module Ports
  (output reg [1:0] port_out,
   input wire [2:0] port_index,
   input wire [1:0] p,
   input wire setup, reset, clk, found
   );
  
  reg [1:0] port [7:0];
 
  
  always @(posedge clk, posedge reset)
    begin
      if (reset) // asynchronous active HIGH reset
        begin
          port[0] <= 2'b00;
          port[1] <= 2'b00;
          port[2] <= 2'b00;
          port[3] <= 2'b00;
          port[4] <= 2'b00;
          port[5] <= 2'b00;
          port[6] <= 2'b00;
          port[7] <= 2'b00;
        end
      else if (setup == 1) //on the first phase (setup), fill the port column
        begin
          port[0] <= p;
          port[1] <= port[0];
          port[2] <= port[1];
          port[3] <= port[2];
          port[4] <= port[3];
          port[5] <= port[4];
          port[6] <= port[5];
          port[7] <= port[6];
        end
      else if (found == 1) //setup 0, search for the input address' destination 							 port
        port_out <= port[port_index];
      else  // found==0: route to default port (00)
		port_out <= 2'b00;
    end
          
endmodule       

  
  

          