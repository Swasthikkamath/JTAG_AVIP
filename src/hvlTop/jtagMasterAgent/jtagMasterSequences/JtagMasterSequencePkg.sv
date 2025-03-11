`ifndef JTAGMASTERSEQUENCEPKG_INCLUDED_
`define JTAGMASTERSEQUENCEPKG_INCLUDED_

package JtagMasterSequencePkg;
  import uvm_pkg :: *;
  `include "uvm_macos.svh"
  import JtagGlobalPkg :: *;
  import JtagMasterPkg :: *;

  `include "JtagMasterBaseSequence.sv"

endpackage : JtagMasterSequencePkg
`endif
