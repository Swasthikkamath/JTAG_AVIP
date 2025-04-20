`ifndef JTAGSLAVECONFIGCONVERTER_INCLUDED_
`define JTAGSLAVECONFIGCONVERTER_INCLUDED_

class JtagSlaveConfigConverter extends uvm_object;
  `uvm_object_utils(JtagSlaveConfigConverter)
  extern function new(string name = "JtagSlaveConfigConverter");
  extern static function void fromClass(input JtagSlaveAgentConfig jtagSlaveAgentConfig,                    output JtagConfigStruct jtagConfigStruct);

endclass : JtagSlaveConfigConverter 

function JtagSlaveConfigConverter :: new(string name = "JtagSlaveConfigConverter");
  super.new(name);
endfunction : new

function void JtagSlaveConfigConverter :: fromClass(input JtagSlaveAgentConfig jtagSlaveAgentConfig,output JtagConfigStruct jtagConfigStruct);
  jtagConfigStruct.jtagTestVectorWidth = jtagSlaveAgentConfig.jtagTestVectorWidth;
  jtagConfigStruct.jtagInstructionWidth = jtagSlaveAgentConfig.jtagInstructionWidth;
  for (int i=0; i<jtagSlaveAgentConfig.jtagInstructionWidth;i++)
   jtagConfigStruct.jtagInstructionOpcode[i] = jtagSlaveAgentConfig.jtagInstructionOpcode[i];
endfunction :fromClass

`endif
