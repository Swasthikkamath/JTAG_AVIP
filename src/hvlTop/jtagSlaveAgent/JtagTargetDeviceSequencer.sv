`ifndef JTAGSLAVEEQUENCER_INCLUDED_
`define JTAGSLAVESEQUENCER_INCLUDED_

class JtagSlaveSequencer extends uvm_sequencer #(JtagSlaveTransaction);
  `uvm_component_utils(JtagSlaveSequencer)

  extern function new(string name = "JtagSlaveSequencer",uvm_component parent);

endclass : JtagSlaveSequencer 

function JtagSlaveSequencer :: new(string name = "JtagSlaveSequencer",uvm_component parent);
  super.new(name,parent);
endfunction  : new

`endif
