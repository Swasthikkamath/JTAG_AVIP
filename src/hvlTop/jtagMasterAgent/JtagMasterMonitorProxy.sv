`ifndef UARTMASTERMONITOR_INCLUDED_
`define UARTMASTERMONITOR_INCLUDED_

class JtagMasterMonitor extends uvm_monitor; 
  `uvm_component_utils(JtagMasterMonitor)
  
  uvm_analysis_port #(JtagMasterTransaction)jtagMasterMonitorAnalysisPort;
  virtual JtagMasterMonitorBfm jtagMasterMonitorBfm;
  JtagMasterAgentConfig jtagMasterAgentConfig;
  
  extern function new(string name = "JtagMasterMonitor" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : JtagMasterMonitor

function JtagMasterMonitor :: new( string name = "JtagMasterMonitor" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagMasterMonitor :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(this,"","jtagMasterAgentConfig",jtagMasterAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TP GET MASTER AGENT CONFIG IN MASTER MONITOR")

//  if(!(uvm_config_db #(JtagMasterMonitorBfm) :: get(this,"","jtagMasterMonitorBfm",jtagMasterMonitorBfm)))
  //  `uvm_fatal(get_type_name(),"FAILED TO GET THE MASTER MONITOR BFM IN MASTER MONITOR")
  
  jtagMasterMonitorAnalysisPort = new("jtagMasterMonitorAnalysisPort",this);
endfunction : build_phase

task JtagMasterMonitor :: run_phase(uvm_phase phase);
  super.run_phase(phase);
endtask : run_phase
`endif
