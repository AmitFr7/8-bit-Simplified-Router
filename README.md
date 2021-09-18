# 8-bit Simplified Router (CAS)

This is an implementation of an 8-bit Simplified Router (content addressed storage) in both Verilog HDL and Logisim.

* Verilog HDL - RTL design of the functionality specified below.
* Logisim - Gate-level implementation of the functionality as described below.

A router is a circuit which can be used to facilitate the routing of data packets from their source to their respective destinations. It does so by maintaining a table of pairs, each pair consists of an address and the output port to be used.

The router receives a packet that consists of data and the address that the packet must be delivered to. The router then looks up the output port corresponding to the destination address, stored in a table as shown below. If such an entry exists for the destination address in the routing table, the router forwards the packet to the required port. If such an entry does not exist, the router routes the data packet to a default port (port 00 in that implementation).

The router functionality consists of 2 phases:

1. **Setup Phase**: in that phase, the Routing Table (which specifies the destinations of 8 different addresses to their ports) is filled in. There are 4 ports (2-bits are required to describe them). By the end of the Setup Phase, the Routing Table is ready and would now be used in order to direct any data or message to its corresponding port (or to the default port, if the destination for the input message is not defined in the table).

2. **Active Phase**: in that phase, any input address is now searched for in the Routing Table, and the output would be the port relevant for that specific address, as described above.

* Note that throughout both phases the Routing Table could be reset using the "reset" signal (which is an asynchronous active HIGH signal, and therefore would reset the table at any given time and will not be limited to constraints of the clock signal's periodic behavior).


## **Project Files:** 

1. **Verilog HDL** - `router.sv` is the design's file and `router_TB.sv` is its test bench. `router_waveform.png` is a screenshot of the test bench waveform and `router_waveform_detailed.png` is another screenshot in which the shift registers' storage of the addresses' and the ports' columns are described throughout the simulation.
 
2. **Logisim** - `8_bit_router.circ` is the Logisim file, and the additional .png files are the images of the circuit's modules themselves: `encoder(1).png`, `encoder(2).png`, `encoder(3).png`, `addresses.png`, `ports.png`, `compare(8).png`, and finally `router.png`.
