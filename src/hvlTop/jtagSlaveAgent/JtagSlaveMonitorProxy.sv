`ifndef UARTSLAVEMONITOR_INCLUDED_
`define UARTSLAVEMONITOR_INCLUDED_

class JtagSlaveMonitor extends uvm_monitor; 
  `uvm_component_utils(JtagSlaveMonitor)
  
  uvm_analysis_port #(JtagSlaveTransaction)jtagSlaveMonitorAnalysisPort;
  virtual JtagSlaveMonitorBfm jtagSlaveMonitorBfm;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;
  
  extern function new(string name = "JtagSlaveMonitor" , uvm_component parent);
  extern virtual function void  build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : JtagSlaveMonitor

function JtagSlaveMonitor :: new( string name = "JtagSlaveMonitor" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagSlaveMonitor :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(this,"","jtagSlaveAgentConfig",jtagSlaveAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TP GET Slave AGENT CONFIG IN Slave MONITOR")

//  if(!(uvm_config_db #(JtagSlaveMonitorBfm) :: get(this,"","jtagSlaveMonitorBfm",jtagSlaveMonitorBfm)))
  //  `uvm_fatal(get_type_name(),"FAILED TO GET THE Slave MONITOR BFM IN Slave MONITOR")
  
  jtagSlaveMonitorAnalysisPort = new("jtagSlaveMonitorAnalysisPort",this);
endfunction : build_phase

task JtagSlaveMonitor :: run_phase(uvm_phase phase);
  super.run_phase(phase);
endtask : run_phase
`endif
