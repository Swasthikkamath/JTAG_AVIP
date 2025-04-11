`ifndef JTAGSLAVEASSERTIONS_INCLUDED_
`define JTAGSLAVEASSERTIONS_INCLUDED_

import JtagGlobalPkg::*;

interface JtagSlaveAssertions (input clk,
                                         input reset,
                                         input jtagSerialOut,
                                         input jtagTms
                                        );
 


  import uvm_pkg::*;
  `include "uvm_macros.svh"; 
 

    initial begin
    `uvm_info("JtagSlaveAssertions","JtagSlaveAssertions",UVM_LOW);
  end

  import JtagSlavePkg ::JtagSlaveAgentConfig;
  
  JtagSlaveAgentConfig jtagSlaveAgentConfig;

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
  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(null , "" , "jtagSlaveAgentConfig" ,jtagSlaveAgentConfig)))
      `uvm_fatal("CONTROLLER DEVICE]" , "FAILED TO GET CONFIG")   
      jtagTestVectorWidth = jtagSlaveAgentConfig.jtagTestVectorWidth;
end 




  always @(posedge  clk)
    begin
    $display("THE WIDTH IS %0d",width);
     if((!($isunknown(jtagSerialOut))) && (width <jtagSlaveAgentConfig.jtagTestVectorWidth)) begin 
       width++;
    end 

     if(width == jtagSlaveAgentConfig.jtagTestVectorWidth) begin 
       startWidthCheck = 1'b 1;
       repeat(2) @(posedge clk);
        startWidthCheck = 1'b 0;
      end 
       //width = 0;
    end 


   property testWidthCheck;
	  @(posedge clk) disable iff (!(startWidthCheck))
              ##1 (((width)== jtagTestVectorWidth));
  endproperty

  assert property (testWidthCheck) begin
  $info("******************************************************************************************************\n [SLAVE ASSERTION] \n Slave TDI WIDTH IS VALID =%0d \n************************************************************************************************************",width);
  width= 1'b 0;
  end
  else
 $error("\n \n \n WIDTH MISMATCH \n \n \n");

endinterface : JtagSlaveAssertions

`endif
