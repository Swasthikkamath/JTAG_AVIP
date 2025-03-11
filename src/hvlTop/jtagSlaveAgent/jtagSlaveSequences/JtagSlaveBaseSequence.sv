`ifndef JTAGSLAVEBASESEQUENCE_INCLUDED_
`define JTAGSLAVEBASESEQUENCE_INCLUDED_

class JtagSlaveBaseSequence extends uvm_sequence#(JtagSlaveTransaction);
  `uvm_object_utils(JtagSlaveBaseSequence) 

  extern function new(string name = "JtagSlaveBaseSequence");
  extern virtual task body();

endclass : JtagSlaveBaseSequence 

function JtagSlaveBaseSequence :: new (string name = "JtagSlaveBaseSequence");
  super.new(name);
endfunction : new

task JtagSlaveBaseSequence :: body();
  req = JtagSlaveTransaction :: type_id :: create("req");

  start_item(req);
  req.randomize();
  req.print();
  finish_item(req);
endtask : body

`endif
