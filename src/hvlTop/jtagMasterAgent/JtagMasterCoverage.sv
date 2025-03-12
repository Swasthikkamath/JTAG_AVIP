`ifndef JTAGMASTERCOVERAGE_INCLUDED_
`define JTAGMASTERCOVERAGE_INCLUDED_

class JtagMasterCoverage extends uvm_subscriber;
  `uvm_component_utils(JtagMasterCoverage)
  
  bit[31:0] data;

  extern function new(string name = "JtagMasterCoverage");
  extern virtual function void build_phase(uvm_phase phase);
  extern function void write(JtagMasterTransaction t);

  covergroup JtagMasterCoverGroup with function sample(bit[31:0]data);

    JtagTestVector_CP : coverpoint TestVector{ bins TestData = {[0:$]};}

  endgroup

endclass : JtagMasterCoverage

function JtagMasterCoverage :: new(string name= "JtagMasterCoverage",uvm_component parent);
 super.new(name,parent);
endfunction : new

function void JtagMasterCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(this,"","jtagMasterAgentConfig",jtagMasterAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET MASTER CONFIG IN COVERRAGE")

    
  JtagMasterCoverGroup = new();
endfunction : build_phase

function void JtagMasterCoverage :: write(JtagMasterTransaction t);
  data =0;
  data = t.jtagTestVector;
  JtagMasterCoverGroup.sample(data);
 
endfunction : write

`endif

