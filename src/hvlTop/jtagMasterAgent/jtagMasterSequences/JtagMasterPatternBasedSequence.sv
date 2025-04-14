
`ifndef JTAGMASTERPATTERNBASEDSEQUENCE_INCLUDED_
`define JTAGMASTERPATTERNBASEDSEQUENCE_INCLUDED_

class JtagMasterPatternBasedSequence extends JtagMasterBaseSequence;
  `uvm_object_utils(JtagMasterPatternBasedSequence)
  logic[31:0]patternNeeded
  extern function new(string name = "JtagMasterPatternBasedSequence");
  extern virtual task body();

endclass : JtagMasterPatternBasedSequence 

function JtagMasterPatternBasedSequence :: new(string name = "JtagMasterPatternBasedSequence");
  super.new(name);
endfunction : new

task JtagMasterPatternBasedSequence :: body();
  super.body();
  req = JtagMasterTransaction :: type_id :: create("req");
  req.randomize() with{jtagTestVector == patternNeeded;};
  req.print();
  start_item(req);
  finish_item(req);
endtask : body

`endif
