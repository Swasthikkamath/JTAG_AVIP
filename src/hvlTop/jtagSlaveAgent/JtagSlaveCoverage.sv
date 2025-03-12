`ifndef JTAGSLAVECOVERAGE_INCLUDED_
`define JTAGSLAVECOVERAGE_INCLUDED_

class JtagSlaveCoverage extends uvm_subscriber#(JtagSlaveTransaction);
  `uvm_component_utils(JtagSlaveCoverage)
  
  bit[31:0] testVector;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;

  extern function new(string name = "JtagSlaveCoverage",uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void write(JtagSlaveTransaction t);

  covergroup JtagSlaveCoverGroup with function sample(bit[31:0]TestVector);

    JtagTestVector_CP : coverpoint TestVector{ bins TestData = {[0:$]};}

  endgroup

endclass : JtagSlaveCoverage

function JtagSlaveCoverage :: new(string name= "JtagSlaveCoverage",uvm_component parent);
 super.new(name,parent);
  JtagSlaveCoverGroup = new();
endfunction : new

function void JtagSlaveCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(this,"","jtagSlaveAgentConfig",jtagSlaveAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET Slave CONFIG IN COVERRAGE")
endfunction : build_phase

function void JtagSlaveCoverage :: write(JtagSlaveTransaction t);
  testVector =0;
  testVector = t.jtagTestVector;
  JtagSlaveCoverGroup.sample(testVector);
 
endfunction : write

`endif
