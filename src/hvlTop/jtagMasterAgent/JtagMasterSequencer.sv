`ifndef JTAGMASTERSEQUENCER_INCLUDED_
`define JTAGMASTERSEQUENCER_INCLUDED_

class JtagMasterSequencer extends uvm_sequencer #(JtagMasterTransaction);
  `uvm_component_utils(JtagMasterSequencer)

  extern function new(string name = "JtagMasterSequencer",uvm_component parent);

endclass : JtagMasterSequencer 

function JtagMasterSequencer :: new(string name = "JtagMasterSequencer",uvm_component parent);
  super.new(name,parent);
endfunction  : new

`endif
