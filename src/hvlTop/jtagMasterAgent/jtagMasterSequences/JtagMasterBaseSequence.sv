`ifndef JTAGMASTERBASESEQUENCE_INCLUDED_
`define JTAGMASTERBASESEQUENCE_INCLUDED_

class JtagMasterBaseSequence extends uvm_sequence#(JtagMasterTransaction);
  `uvm_object_utils(JtagMasterBaseSequence) 

  rand int numberOfTests;
  extern function new(string name = "JtagMasterBaseSequence");
  extern virtual task body();

endclass : JtagMasterBaseSequence 

function JtagMasterBaseSequence :: new (string name = "JtagMasterBaseSequence");
  super.new(name);
endfunction : new

task JtagMasterBaseSequence :: body();
  req = JtagMasterTransaction :: type_id :: create("req");
   req.randomize();
  req.print();
  start_item(req);
 
 
  finish_item(req);
endtask : body

`endif
