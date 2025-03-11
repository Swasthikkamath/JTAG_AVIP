//--------------------------------------------------------------------------------------------
// Module      : jtag Transmitter Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module JtagTxAgentBfm(jtagIf jtagIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("jtag transmitter agent bfm",$sformatf("JTAG TRANSMITTER AGENT BFM"),UVM_LOW)
  end
  
  //-------------------------------------------------------
  // Transmitter driver bfm instantiation
  //-------------------------------------------------------
  
  JtagMasterDriverBfm jtagMasterDriverBfm ();

  //-------------------------------------------------------
  // Transmitter monitor bfm instantiation
  //-------------------------------------------------------
  
 JtagMasterMonitorBfm jtagMasterMonitorBfm ();


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual JtagMasterDriverBfm)::set(null,"*","jtagMasterDriverBfm",jtagMasterDriverBfm);
    uvm_config_db#(virtual JtagMasterMonitorBfm)::set(null,"*","jtagMasterMonitorBfm",jtagMasterMonitorBfm);
  end

//  bind jtagMasterMonitorBfm jtagMasterAssertions TestVectrorTestingAssertions();

endmodule : jtagTxAgentBfm
