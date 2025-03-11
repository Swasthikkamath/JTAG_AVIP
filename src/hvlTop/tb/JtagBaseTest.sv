`ifndef JTAGBASETEST_INCLUDED_
`define JTAGBASETEST_INCLUDED_

class JtagBaseTest extends uvm_test;
  `uvm_component_utils(JtagBaseTest)

  JtagMasterTestingVirtualSequence jtagMasterTestingVirtualSequence;
  JtagEnv jtagEnv;
  JtagEnvConfig jtagEnvConfig;
  
  extern function new(string name = "JtagBaseTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void setupJtagEnvConfig();
  extern function void setupJtagMasterAgentConfig();
  extern function void setupJtagSlaveAgentConfig();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagBaseTest


function JtagBaseTest :: new(string name = "JtagBaseTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagBaseTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  setupJtagEnvConfig();
  jtagEnv = JtagEnv :: type_id :: create("jtagEnv",this);
endfunction : build_phase

function void  JtagBaseTest :: setupJtagEnvConfig();
  jtagEnvConfig = JtagEnvConfig :: type_id :: create("jtagEnvConfig");
  jtagEnvConfig.hasScoreboard = 1 ;
  jtagEnvConfig.hasVirtualSequencer = 1;
  uvm_config_db #(JtagEnvConfig) :: set(this,"*", "jtagEnvConfig",jtagEnvConfig);
  setupJtagMasterAgentConfig();
  setupJtagSlaveAgentConfig();
endfunction : setupJtagEnvConfig

function void  JtagBaseTest :: setupJtagMasterAgentConfig();
  jtagEnvConfig.jtagMasterAgentConfig = JtagMasterAgentConfig :: type_id :: create("jtagMasterAgentConfig");
  jtagEnvConfig.jtagMasterAgentConfig.hasCoverage =1;
  jtagEnvConfig.jtagMasterAgentConfig.is_active = UVM_ACTIVE;
  uvm_config_db #(JtagMasterAgentConfig) :: set(null,"*", "jtagMasterAgentConfig",jtagEnvConfig.jtagMasterAgentConfig);

endfunction : setupJtagMasterAgentConfig

function void  JtagBaseTest :: setupJtagSlaveAgentConfig();
 jtagEnvConfig.jtagSlaveAgentConfig = JtagSlaveAgentConfig :: type_id :: create("jtagSlaveAgentConfig");
 jtagEnvConfig.jtagSlaveAgentConfig.hasCoverage =1;
 jtagEnvConfig.jtagSlaveAgentConfig.is_active = UVM_PASSIVE;
  uvm_config_db #(JtagSlaveAgentConfig) :: set(null,"*", "jtagSlaveAgentConfig",jtagEnvConfig.jtagSlaveAgentConfig);
endfunction : setupJtagSlaveAgentConfig

function void JtagBaseTest :: end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction :  end_of_elaboration_phase

task  JtagBaseTest :: run_phase(uvm_phase phase);
  jtagMasterTestingVirtualSequence = JtagMasterTestingVirtualSequence :: type_id :: create("JtagMasterTestingVirtualSequence");
  jtagMasterTestingVirtualSequence.setConfig(jtagEnvConfig.jtagMasterAgentConfig);
  phase.raise_objection(this);
    jtagMasterTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  phase.drop_objection(this);

endtask : run_phase

`endif



  
