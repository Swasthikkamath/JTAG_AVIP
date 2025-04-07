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

 $display("the serial in is %b ",jtagSerialIn);
end 




  always @(posedge  clk)
    begin 
     if((!($isunknown(jtagSerialIn))) && (width < jtagMasterAgentConfig.jtagInstructionWidth)) begin 
       width++;
       $display("****************************************************\n width =%0d \n ***********************************",width);
       instruction = {jtagSerialIn,instruction[4:1]};
       $display("instruction is %b",instruction);
    end 

     if(width == jtagMasterAgentConfig.jtagInstructionWidth) begin 
       startValidityCheck = 1'b 1;
       startWidthCheck = 1'b 1;
       repeat(2) @(posedge clk);
        startValidityCheck = 1'b 0;
	repeat(3) @(posedge clk);
        width =1;
	while(width <= 16)
	 begin 
          width++;
          test = {jtagSerialIn , test[15:1]};
	  $display("THE RESULTANT TEST IS %b",test);
           @(posedge clk);
	 end
  $display("the width here is %0d",width);	 
	 testVectorCheck =1;


      end 
       //width = 0;
    end 


   property instructionValidityCheck;
	  @(posedge clk) disable iff (!(startValidityCheck))
              ##1  ((instruction  == jtagInstruction) && ((width)== jtagInstructionWidth));
  endproperty

  assert property (instructionValidityCheck)
  $info(" \n \n \n \n INSTRUCTION BITS ARE VALID \n \n \n \n ");
  else
 $error("\n \n \n INSTRUCTION BIT IS UNKNOWN ");


    property testVectorValidity;
	  @(posedge clk) disable iff (!testVectorCheck)
        (##1 (width-1 == jtagTestVectorWidth) );
  endproperty

  assert property (testVectorValidity) begin 
  $info("\n \n \n TEST VECTOR IS VALID \n \n \n ");
  testVectorCheck = 0;
  end 
  else
  $error("TEST VECTOR  INVALID ");



endinterface : JtagMasterAssertions

`endif

