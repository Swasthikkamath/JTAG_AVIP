`ifndef JTAGMASTERASSERTIONS_INCLUDED_
`define JTAGMASTERASSERTIONS_INCLUDED_

import JtagGlobalPkg::*;

interface JtagMasterAssertions (input clk,
                                         input reset,
                                         input jtagSerialIn,
                                         input jtagTms
                                        );
 


  import uvm_pkg::*;
  `include "uvm_macros.svh"; 
 

    initial begin
    `uvm_info("JtagMasterAssertions","JtagMasterAssertions",UVM_LOW);
  end

  import JtagMasterPkg ::JtagMasterAgentConfig;
  
  JtagMasterAgentConfig jtagMasterAgentConfig;

  bit startValidityCheck;
  bit startWidthCheck;

  bit[5:0] width=0;
  logic[4:0] instruction;
  logic[15:0]dataTest;
  logic[15:0] test;
  bit testVectorCheck;
  JtagInstructionWidthEnum jtagInstructionWidth;
  JtagTestVectorWidthEnum jtagTestVectorWidth;
  JtagInstructionOpcodeEnum jtagInstruction;
 always @(posedge clk) begin 
  if(!(uvm_config_db #(JtagMasterAgentConfig) :: get(null , "" , "jtagMasterAgentConfig" ,jtagMasterAgentConfig)))
      `uvm_fatal("CONTROLLER DEVICE]" , "FAILED TO GET CONFIG")

      jtagInstructionWidth = jtagMasterAgentConfig.jtagInstructionWidth;
      jtagTestVectorWidth = jtagMasterAgentConfig.jtagTestVectorWidth;
      jtagInstruction = jtagMasterAgentConfig.jtagInstructionOpcode;
      $display("THE INSTRUCTION  WIDTH IS %s",jtagInstructionWidth.name());

end 




  always @(posedge  clk)
    begin
     //$display("THE WIDTH OF MASTER WIDTH IS %0d and data in is %0b",width,jtagSerialIn);
     if((!($isunknown(jtagSerialIn))) && (width < jtagMasterAgentConfig.jtagInstructionWidth) &&(!($isunknown(jtagTms)))) begin 
       width++;
       instruction = {jtagSerialIn,instruction[4:1]};
    end 

     if(width == jtagMasterAgentConfig.jtagInstructionWidth && (!($isunknown(jtagTms)))) begin 
       startValidityCheck = 1'b 1;
       repeat(2) @(posedge clk);
        startValidityCheck = 1'b 0;
	repeat(3) @(posedge clk);
        width =0;
	while(width < jtagTestVectorWidth)
	 begin 
          width++;

           @(posedge clk);

	 end
	 testVectorCheck =1;

      end 
    $display("THE WIDTH OF MASTER WIDTH IS %0d and data in is %0b @%0t",width,jtagSerialIn,$time);
    end 


   property instructionValidityCheck;
	  @(posedge clk) disable iff (!(startValidityCheck))
              ##1  (((width)== jtagInstructionWidth));
  endproperty

  assert property (instructionValidityCheck)
  $info("*************************************************************************************************************\n[MASTER ASSERTION]\n INSTRUCTION %b MATCHES AND WIDTH %0d  IS CORRECT \n**************************************************************************************************************",instruction,width);
  else
 $error("\n \n \n INSTRUCTION BIT IS UNKNOWN ");


    property testVectorValidity;
	  @(posedge clk) disable iff (!testVectorCheck)
        (##1 (width == jtagTestVectorWidth) );
  endproperty

  assert property (testVectorValidity) begin 
  $info("*************************************************************************************************************\n[MASTER ASSERTION]\nTEST VECTOR WIDTH %0d MATCHES \n************************************************************************************************************",width);
  testVectorCheck = 0;
  width=0;
  end 
  else
  $error("TEST VECTOR  INVALID ");



endinterface : JtagMasterAssertions

`endif

