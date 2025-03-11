
//--------------------------------------------------------------------------------------------
// Module      : jtag Master Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module JtagMasterAgentBfm(JtagIf jtagIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("jtag Master agent bfm",$sformatf("JTAG Master AGENT BFM"),UVM_LOW)
  end
  
  //-------------------------------------------------------
  // Master driver bfm instantiation
  //-------------------------------------------------------
  
  JtagMasterDriverBfm jtagMasterDriverBfm (.clk(jtagIf.clk),.jtagSerialIn(jtagIf.jtagSerialIn),.reset(jtagIf.reset));

  //-------------------------------------------------------
  // Master monitor bfm instantiation
  //-------------------------------------------------------
  
 JtagMasterMonitorBfm jtagMasterMonitorBfm (.clk(jtagIf.clk),.jtagSerialIn(jtagIf.jtagSerialIn),.reset(jtagIf.reset));


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual JtagMasterDriverBfm)::set(null,"*","jtagMasterDriverBfm",jtagMasterDriverBfm);
    uvm_config_db#(virtual JtagMasterMonitorBfm)::set(null,"*","jtagMasterMonitorBfm",jtagMasterMonitorBfm);
  end

//  bind jtagMasterMonitorBfm jtagMasterAssertions TestVectrorTestingAssertions();

endmodule : JtagMasterAgentBfm
