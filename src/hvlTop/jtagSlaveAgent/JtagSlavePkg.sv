`ifndef JTAGMSLAVEPKG_INCLUDED_
`define JTAGSLAVEPKG_INCLUDED_

package JtagSlavePkg;
  `include "uvm_macros.svh"

  import uvm_pkg :: *;
  import JtagGlobalPkg :: *;
  `include "JtagSlaveAgentConfig.sv"
  `include "JtagSlaveTransaction.sv"
  //`include "JtagSlaveSeqItemConverter.sv"
  //`include "JtagSlaveConfigConverter.sv"
  `include "JtagSlaveSequencer.sv"
  `include "JtagSlaveDriverProxy.sv"
  `include "JtagSlaveMonitorProxy.sv"
  //`include "JtagSlaveCoverage.sv"
  `include "JtagSlaveAgent.sv"

endpackage : JtagSlavePkg

`endif
