`ifndef JTAGMASTERPKG_INCLUDED_
`define JTAGMASTERPKG_INCLUDED_

package JtagMasterPkg;
  `include "uvm_macros.svh"

  import uvm_pkg :: *;
  import JtagGlobalPkg :: *;
  `include "JtagMasterAgentConfig.sv"
  `include "JtagMasterTransaction.sv"
  //`include "JtagMasterSeqItemConverter.sv"
  //`include "JtagMasterConfigConverter.sv"
  `include "JtagMasterSequencer.sv"
  `include "JtagMasterDriverProxy.sv"
  `include "JtagMasterMonitorProxy.sv"
  //`include "JtagMasterCoverage.sv"
  `include "JtagMasterAgent.sv"

endpackage : JtagMasterPkg

`endif
