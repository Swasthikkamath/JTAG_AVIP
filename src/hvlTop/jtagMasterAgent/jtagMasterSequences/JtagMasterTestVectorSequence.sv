`ifndef JTAGMASTERTESTVECTORSEQUENCE_INCLUDED_
`define JTAGMASTERTESTVECTORSEQUENCE_INCLUDED_

class JtagMasterTestVectorSequence extends JtagMasterBaseSequence;
  `uvm_object_utils(JtagMasterTestVectorSequence)

  extern function new(string name = "JtagMasterTestVectorSequence");
  extern virtual task body();

endclass : JtagMasterTestVectorSequence 

function JtagMasterTestVectorSequence :: new(string name = "JtagMasterTestVectorSequence");
  super.new(name);
endfunction : new

task JtagMasterTestVectorSequence :: body();
  super.body();
  req = JtagMasterTransaction :: type_id :: create("req");
  req.randomize();
  req.print();
  start_item(req);
  finish_item(req);
endtask : body

`endif
