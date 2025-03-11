//--------------------------------------------------------------------------------------------
// Module      : jtag Slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module JtagSlaveAgentBfm(JtagIf jtagIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("jtag slave agent bfm",$sformatf("JTAG SLAVE AGENT BFM"),UVM_LOW)
  end
  
  //-------------------------------------------------------
  // Slave driver bfm instantiation
  //-------------------------------------------------------
  
  JtagSlaveDriverBfm jtagSlaveDriverBfm (.clk(jtagIf.clk),.jtagSerialOut(jtagIf.jtagSerialOut),.reset(jtagIf.reset));

  //-------------------------------------------------------
  // Slave monitor bfm instantiation
  //-------------------------------------------------------
  
  JtagSlaveMonitorBfm jtagSlaveMonitorBfm (.clk(jtagIf.clk),.jtagSerialOut(jtagIf.jtagSerialOut),.reset(jtagIf.reset));


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual JtagSlaveDriverBfm)::set(null,"*","jtagSlaveDriverBfm",jtagSlaveDriverBfm);
    uvm_config_db#(virtual JtagSlaveMonitorBfm)::set(null,"*","jtagSlaveMonitorBfm",jtagSlaveMonitorBfm);
  end

//  bind jtagSlaveMonitorBfm jtagSlaveAssertions TestVectrorTestingAssertions();

endmodule : JtagSlaveAgentBfm
