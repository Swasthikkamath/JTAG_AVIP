`ifndef JTAGMASTERASSERTIONS_INCLUDED_
`define JTAGMASTERASSERTIONS_INCLUDED_

import JtagGlobalPkg::*;

interface JtagMasterAssertions (input clk,
                                         input reset,
                                         input jtagSerialIn,
                                         input jtagTms
                                        );
 


  import uvm_pkg::*;
  `include "uvm_macros.svh"; 
 

    initial begin
    `uvm_info("JtagMasterAssertions","JtagMasterAssertions",UVM_LOW);
  end

    property isJtagTmsvalid;
	  @(posedge clk) disable iff (reset)
    !($isunknown(jtagTms));
  endproperty

  assert property (isJtagTmsvalid)
  $info("JTAG_TMS_VALUE IS VALID");
  else
  $error("JTAG_TMS_VALUE IS UNKNOWN ");


    property isJtagSerialInvalid;
	  @(posedge clk) disable iff (reset)
    !($isunknown(jtagSerialIn));
  endproperty

  assert property (isJtagSerialInvalid)
  $info("JTAG_SERIAL_DATAIN_VALUE IS VALID");
  else
  $error("JTAG_SERIAL_DATAIN_VALUE IS UNKNOWN ");

    property JtagResetCheck;
	  @(posedge clk) disable iff (reset)
    jtagTms |=> jtagTms[*4]; 
  endproperty
  
  assert property (JtagResetCheck)
  $info("RESET ASSERTED");
  else
  $error("RESET NOT ASSERTED");



endinterface : JtagMasterAssertions

`endif

