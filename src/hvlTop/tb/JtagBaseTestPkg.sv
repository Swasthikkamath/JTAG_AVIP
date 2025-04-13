`ifndef JTAGBASETESTPKG_INCLUDED_
`define JTAGBASETESTPKG_INCLUDED_

package JtagBaseTestPkg;
  `include "uvm_macros.svh"

  import uvm_pkg :: *;
  import JtagGlobalPkg :: *;

  import JtagMasterPkg :: *;
  import JtagSlavePkg :: *;
  import JtagEnvPkg :: *;
  import JtagMasterSequencePkg :: *;
  import JtagSlaveSequencePkg :: *;
  import JtagVirtualSequencePkg :: *;

  `include "JtagBaseTest.sv"
  `include "JtagTdiWidth8Test.sv"
  `include "JtagTdiWidth16Test.sv"
  `include "JtagTdiWidth24Test.sv"

 endpackage : JtagBaseTestPkg

 `endif
