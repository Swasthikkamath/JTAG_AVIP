`ifndef JTAGMASTERBASESEQUENCE_INCLUDED_
`define JTAGMASTERBASESEQUENCE_INCLUDED_

class JtagMasterBaseSequence extends uvm_sequence#(JtagMasterTransaction);
  `uvm_object_utils(JtagMasterBaseSequence) 

  extern function new(string name = "JtagMasterBaseSequence");
  extern virtual function body();

endclass : JtagMasterBaseSequence 

function JtagMasterBaseSequence :: new (string name = "JtagMasterBaseSequence");
  super.new(name);
endfunction : new

task JtagMasterBaseSequence :: body();
  super.body();

  req = JtagMasterTransaction :: type_id :: create("req");

  start_item(req);
  req.randomize();
  req.print();
  finish_item(req);
endtask : body

`endif
