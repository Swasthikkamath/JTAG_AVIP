//--------------------------------------------------------------------------------------------
// Module      : jtag TargetDevice Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module JtagTargetDeviceAgentBfm(JtagIf jtagIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("jtag TargetDevice agent bfm",$sformatf("JTAG TargetDevice AGENT BFM"),UVM_LOW)
  end
  
  //-------------------------------------------------------
  // TargetDevice driver bfm instantiation
  //-------------------------------------------------------
  
  JtagTargetDeviceDriverBfm jtagTargetDeviceDriverBfm (.clk(jtagIf.clk),.jtagSerialOut(jtagIf.Tdo),.reset(jtagIf.reset),.jtagTms(jtagIf.Tms),.jtagSerialIn(jtagIf.Tdi));

  //-------------------------------------------------------
  // TargetDevice monitor bfm instantiation
  //-------------------------------------------------------
  
  JtagTargetDeviceMonitorBfm jtagTargetDeviceMonitorBfm (.clk(jtagIf.clk),.jtagSerialIn(jtagIf.Tdi),.jtagSerialOut(jtagIf.Tdo),.reset(jtagIf.reset),.jtagTms(jtagIf.Tms));


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual JtagTargetDeviceDriverBfm)::set(null,"*","jtagTargetDeviceDriverBfm",jtagTargetDeviceDriverBfm);
    uvm_config_db#(virtual JtagTargetDeviceMonitorBfm)::set(null,"*","jtagTargetDeviceMonitorBfm",jtagTargetDeviceMonitorBfm);
  end

  bind JtagTargetDeviceMonitorBfm JtagTargetDeviceAssertions TestVectrorTestingAssertions(.clk(jtagIf.clk),.Tdo(jtagIf.Tdo),.Tms(jtagIf.Tms),.reset(jtagIf.reset));

endmodule : JtagTargetDeviceAgentBfm
