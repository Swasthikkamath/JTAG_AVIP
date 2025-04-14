`ifndef JTAGMASTERSEQUENCEPKG_INCLUDED_
`define JTAGMASTERSEQUENCEPKG_INCLUDED_

package JtagMasterSequencePkg;
  import uvm_pkg :: *;
  `include "uvm_macros.svh"
  import JtagGlobalPkg :: *;
  import JtagMasterPkg :: *;

  `include "JtagMasterBaseSequence.sv"
  `include "JtagMasterTestVectorSequence.sv"
  `include "JtagMasterPatternBasedSequence.sv"
endpackage : JtagMasterSequencePkg
`endif
