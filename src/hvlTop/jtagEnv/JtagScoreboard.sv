`ifndef JTAGSCOREBOARD_INCLUDED_
`define JTAGSCOREBOARD_INCLUDED_

class JtagScoreboard extends uvm_scoreboard;
 `uvm_component_utils(JtagScoreboard)

 uvm_analysis_export #(JtagMasterTransaction) jtagScoreboardMasterAnalysisExport;
 uvm_analysis_export #(JtagSlaveTransaction)  jtagScoreboardSlaveAnalysisExport;

 uvm_tlm_analysis_fifo #(JtagMasterTransaction) jtagScoreboardMasterAnalysisFifo;
 uvm_tlm_analysis_fifo #(JtagSlaveTransaction) jtagScoreboardSlaveAnalysisFifo; 
 
 JtagMasterTransaction jtagMasterTransaction;
 JtagSlaveTransaction jtagSlaveTransaction;

 extern function new(string name = "JtagScoreboard" , uvm_component parent);
 extern virtual function void build_phase(uvm_phase phase);
 extern virtual function void connect_phase(uvm_phase phase);
 extern virtual task run_phase(uvm_phase phase);

endclass : JtagScoreboard


function JtagScoreboard  :: new (string name = "JtagScoreboard",uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagScoreboard :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagScoreboardMasterAnalysisExport = new("jtagScoreboardMasterAnalysisExport",this);
  jtagScoreboardSlaveAnalysisExport = new("jtagScoreboardSlaveAnalysisExport",this);
  jtagScoreboardMasterAnalysisFifo = new("jtagScoreboardMasterAnalysisFifo",this);
  jtagScoreboardSlaveAnalysisFifo = new("jtagScoreboardSlaveAnalysisFifo",this);
 
endfunction : build_phase

function void JtagScoreboard :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  jtagScoreboardMasterAnalysisExport.connect(jtagScoreboardMasterAnalysisFifo.analysis_export);
  jtagScoreboardSlaveAnalysisExport.connect(jtagScoreboardSlaveAnalysisFifo.analysis_export);

endfunction:connect_phase

task compareResult(JtagMasterTransaction jtagMasterTransaction,JtagSlaveTransaction jtagSlaveTransaction);
  if((jtagMasterTransaction.jtagTestVector ===jtagSlaveTransaction.jtagTestVector)&& (jtagMasterTransaction.jtagInstruction===jtagSlaveTransaction.jtagInstruction))
  begin 
    `uvm_info("[ PASS ]",$sformatf("TDI = %b AND INSTRUCTION=%b",jtagMasterTransaction.jtagTestVector,jtagMasterTransaction.jtagInstruction),UVM_LOW);
  end 
  else begin 
   `uvm_info("[ FAIL ]",$sformatf("TDI = %b AND INSTRUCTION=%b",jtagMasterTransaction.jtagTestVector,jtagMasterTransaction.jtagInstruction),UVM_LOW);
  end 
endtask 

task JtagScoreboard :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin 
    jtagScoreboardMasterAnalysisFifo.get(jtagMasterTransaction);
    `uvm_info("[MASTER TRANSACTION IN SCB]",$sformatf("THE INSTRUCTION IS %b and test vector is %b",jtagMasterTransaction.jtagInstruction,jtagMasterTransaction.jtagTestVector),UVM_LOW);
  
  jtagScoreboardSlaveAnalysisFifo.get(jtagSlaveTransaction);
   `uvm_info("[SLAVE TRANSACTION IN SCB]",$sformatf("THE INSTRUCTION IS %b and test vector is %b",jtagSlaveTransaction.jtagInstruction,jtagSlaveTransaction.jtagTestVector),UVM_LOW);

compareResult(jtagMasterTransaction,jtagSlaveTransaction);

  end 
endtask : run_phase 

`endif
