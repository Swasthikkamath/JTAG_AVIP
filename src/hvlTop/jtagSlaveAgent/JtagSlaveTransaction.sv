`ifndef JTAGSLAVETRANSACTION_INCLUDED_
`define JTAGSLAVETRANSACTION_INCLUDED_

class JtagSlaveTransaction extends uvm_sequence_item;

  `uvm_object_utils(JtagSlaveTransaction)

  logic[31:0]jtagTestVector;
  extern function new(string name = "JtagSlaveTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs , uvm_comparer comparer = null);
  extern function void do_print(uvm_printer printer);

endclass : JtagSlaveTransaction

function JtagSlaveTransaction :: new(string name = "JtagSlaveTransaction");
  super.new(name);
endfunction  : new


function void JtagSlaveTransaction  :: do_copy(uvm_object rhs);
  JtagSlaveTransaction sourceObject;

  if(!($cast(sourceObject,rhs)))
    `uvm_fatal("DO_COPY","THE TYPE OF SOURCE IS NOT COMPTATIBLE")
 
  super.copy(rhs);
  this.jtagTestVector = sourceObject.jtagTestVector;
endfunction : do_copy

function bit  JtagSlaveTransaction :: do_compare(uvm_object rhs,uvm_comparer comparer=null);
  JtagSlaveTransaction sourceObject;

  if(!($cast(sourceObject,rhs)))
   `uvm_fatal("DO_COMPARE","THE TYPE OF SOURCE IS NOT COMPATIBLE")

  return (super.compare(rhs,comparer) && (this.jtagTestVector == sourceObject.jtagTestVector));
endfunction : do_compare

function void JtagSlaveTransaction :: do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field($sformatf("TEST VECTOR"),this.jtagTestVector,$bits(this.jtagTestVector),UVM_BIN);
endfunction : do_print

`endif
