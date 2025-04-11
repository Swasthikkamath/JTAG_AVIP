`ifndef JTAGMASTERDRIVER_INCLUDED_
`define JTAGMASTERDRIVER_INCLUDED_

class JtagMasterDriver extends uvm_driver#(JtagMasterTransaction);
  `uvm_component_utils(JtagMasterDriver)
  virtual JtagMasterDriverBfm jtagMasterDriverBfm;
  JtagMasterAgentConfig jtagMasterAgentConfig;
  JtagConfigStruct jtagConfigStruct;
  JtagPacketStruct jtagPacketStruct;
  extern function new (string name = "JtagMasterDriver", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : JtagMasterDriver

function JtagMasterDriver::new(string name = "JtagMasterDriver",uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void JtagMasterDriver :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(this,"","jtagMasterAgentConfig",jtagMasterAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG IN MASTER DRIVER")

    if(!(uvm_config_db #(virtual JtagMasterDriverBfm) :: get(this,"","jtagMasterDriverBfm",jtagMasterDriverBfm)))
      `uvm_fatal(get_type_name(),"FAILED TO GET VIRTUAL POINTER TO MASTER DRIVERBFM IN MASTER DRIVER")
endfunction : build_phase

task JtagMasterDriver :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  JtagMasterConfigConverter :: fromClass(jtagMasterAgentConfig,jtagConfigStruct);
 
  $display("ENTERED TO DRIVER PROXY SUCCESSFULLY");
  forever begin 
  seq_item_port.get_next_item(req);
 
  $display("\nTHE CONFIG FOR THE CONTROLLER DEVICE ARE: \nTHE TEST VECTOR WIDTH IS %0d \nTHE INSTRUCTION WIDTH IS %0d\n",jtagConfigStruct.jtagTestVectorWidth,jtagConfigStruct.jtagInstructionWidth); 
  JtagMasterSeqItemConverter :: fromClass(req ,jtagConfigStruct,jtagPacketStruct);
  $display("************************************************************************************************************************************************************************************************************\n \t \t THE SENT SENT FROM CONTROLLER DEVICE IS %b \n \t \t THE TMS BEING SENT IS %b \n************************************************************************************************************************************************************************************************************\n",jtagPacketStruct.jtagTestVector,jtagPacketStruct.jtagTms);
  jtagMasterDriverBfm.waitForReset();
  jtagMasterDriverBfm.DriveToBfm(jtagPacketStruct,jtagConfigStruct); 
  
  seq_item_port.item_done(rsp);
  end 
endtask : run_phase

`endif
