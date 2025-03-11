`ifndef JTAGSLAVESEQUENCEPKG_INCLUDED_
`define JTAGSLAVESEQUENCEPKG_INCLUDED_

package JtagSlaveSequencePkg;
  import uvm_pkg :: *;
  `include "uvm_macos.svh"
  import JtagGlobalPkg :: *;
  import JtagSlavePkg :: *;

  `include "JtagSlaveBaseSequence.sv"

endpackage : JtagSlaveSequencePkg
`endif
