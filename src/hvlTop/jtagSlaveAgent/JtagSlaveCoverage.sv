`ifndef JTAGSLAVECOVERAGE_INCLUDED_
`define JTAGSLAVECOVERAGE_INCLUDED_

class JtagSlaveCoverage extends uvm_subscriber#(JtagSlaveTransaction);
  `uvm_component_utils(JtagSlaveCoverage)
  
  bit[31:0] testVector;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;
  int j;
  extern function new(string name = "JtagSlaveCoverage",uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void write(JtagSlaveTransaction t);

  covergroup JtagSlaveCoverGroup with function sample(bit[31:0]TDO , JtagSlaveAgentConfig jtagSlaveAgentConfig);
   JtagTestVector_CP : coverpoint TDO{ bins low_range = {[0:(2**12)]};
                                                  bins mid_range = {[(2**12)+1 : 2**24]} ;
		                                bins high_range = {[(2**24)+1 : 0]}}
   		
   JTAG_TESTVECTOR_WIDTH : coverpoint jtagSlaveAgentConfig.jtagTestVectorWidth{ bins TDO_WIDTH_8 = {testVectorWidth8Bit};
                                                                                 bins TDO_WIDTH_16 = {testVectorWidth16Bit};
										 bins TDO_WIDTH_24 = {testVectorWidth24Bit};
									         bins TDI_WIDTH_32 = {testVectorWidth32Bit};
										}
   JTAG_INSTRUCTION_WIDTH:coverpoint jtagSlaveAgentConfig.jtagInstructionWidth{ bins INSTRUCTION_WIDTH_3 = {instructionWidth3Bit};
                                                                                 bins INSTRUCTION_WIDTH_4 = {instructionWidth4Bit};
										 bins INSTRUCTION_WIDTH_5 = {instructionWidth5Bit};
   										    }	
   JTAG_INSTRUCTION : coverpoint jtagSlaveAgentConfig.jtagInstructionOpcode;

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
    for(int i=0;i<62 ;i++)
      if(!($isunknown(t.jtagTestVector[i])))
        testVector[j++] = t.jtagTestVector[i];
  JtagSlaveCoverGroup.sample(testVector , jtagSlaveAgentConfig);
 
endfunction : write

`endif
