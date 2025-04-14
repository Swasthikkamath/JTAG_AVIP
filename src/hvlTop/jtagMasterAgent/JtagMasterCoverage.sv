`ifndef JTAGMASTERCOVERAGE_INCLUDED_
`define JTAGMASTERCOVERAGE_INCLUDED_

class JtagMasterCoverage extends uvm_subscriber#(JtagMasterTransaction);
  `uvm_component_utils(JtagMasterCoverage)
  
  bit[31:0] testVector;
  bit[4:0]instruction;
  JtagMasterAgentConfig jtagMasterAgentConfig;
  int j;
  int index;
  extern function new(string name = "JtagMasterCoverage",uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void write(JtagMasterTransaction t);
  extern function void report_phase(uvm_phase phase);
  covergroup JtagMasterCoverGroup with function sample(bit[31:0]TestVector,JtagMasterAgentConfig jtagMasterAgentConfig);

    JtagTestVector_CP : coverpoint TestVector{ bins TestData = {[0:$]};}
   
    JTAG_TESTVECTOR_WIDTH : coverpoint jtagMasterAgentConfig.jtagTestVectorWidth{ bins TDI_WIDTH_8 = {testVectorWidth8Bit};
     										  bins TDI_WIDTH_16 = {testVectorWidth16Bit};
										   bins TDI_WIDTH_24 = {testVectorWidth24Bit};
										    bins TDI_WIDTH_32 = {testVectorWidth32Bit};
										    }

    JTAG_INSTRUCTION_WIDTH:coverpoint jtagMasterAgentConfig.jtagInstructionWidth{ bins INSTRUCTION_WIDTH_3 = {instructionWidth3Bit};
                                                                                   bins INSTRUCTION_WIDTH_4 = {instructionWidth4Bit};
										    bins INSTRUCTION_WIDTH_5 = {instructionWidth5Bit};
										    }
    JTAG_INSTRUCTION : coverpoint jtagMasterAgentConfig.jtagInstructionOpcode;
  endgroup

endclass : JtagMasterCoverage

function JtagMasterCoverage :: new(string name= "JtagMasterCoverage",uvm_component parent);
 super.new(name,parent);
  JtagMasterCoverGroup = new();
endfunction : new

function void JtagMasterCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(this,"","jtagMasterAgentConfig",jtagMasterAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET MASTER CONFIG IN COVERRAGE")
endfunction : build_phase

function void JtagMasterCoverage :: write(JtagMasterTransaction t);
  testVector =0;
  for(int i=0;i<62 ;i++)
  if(!($isunknown(t.jtagTestVector[i])))
  testVector[j++] = t.jtagTestVector[i];

    
  JtagMasterCoverGroup.sample(testVector,jtagMasterAgentConfig );
 
endfunction : write

function void  JtagMasterCoverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("******************** JTAGController Agent Coverage = %0.2f %% *********************",  JtagMasterCoverGroup.get_coverage()), UVM_NONE);
  endfunction: report_phase
`endif

