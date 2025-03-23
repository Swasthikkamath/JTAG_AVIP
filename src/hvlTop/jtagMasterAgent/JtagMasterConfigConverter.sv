`ifndef JTAGMASTERCONFIGCONVERTER_INCLUDED_
`define JTAGMASTERCONFIGCONVERTER_INCLUDED_

class JtagMasterConfigConverter extends uvm_object;
  `uvm_object_utils(JtagMasterConfigConverter)
  extern function new(string name = "JtagMasterConfigConverter");
  extern static function void fromClass(input JtagMasterAgentConfig jtagMasterAgentConfig,                    output JtagConfigStruct jtagConfigStruct);

endclass : JtagMasterConfigConverter 

function JtagMasterConfigConverter :: new(string name = "JtagMasterConfigConverter");
  super.new(name);
endfunction : new

function void JtagMasterConfigConverter :: fromClass(input JtagMasterAgentConfig jtagMasterAgentConfig,               output JtagConfigStruct jtagConfigStruct);
  jtagConfigStruct.jtagTestVectorWidth = jtagMasterAgentConfig.jtagTestVectorWidth;
  jtagConfigStruct.jtagInstructionWidth = jtagMasterAgentConfig.jtagInstructionWidth;
  for (int i=0; i<jtagMasterAgentConfig.jtagInstructionWidth;i++)
   jtagConfigStruct.jtagInstructionOpcode[i] = jtagMasterAgentConfig.jtagInstructionOpcode[i];

endfunction :fromClass

`endif
