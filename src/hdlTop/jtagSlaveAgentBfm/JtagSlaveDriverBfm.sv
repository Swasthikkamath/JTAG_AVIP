//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagSlaveDriverBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagSlaveDriverBfm (input  logic   clk,
                              input  logic   reset,
			     input logic jtagSerialIn,
			     input logic jtagTms,
			     output logic  jtagSerialOut
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
	
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagSlavePkg::*;
  JtagTapStates jtagTapState;
  reg byPassRegister;
  reg[(JTAGREGISTERWIDTH -1):0]registerBank[JtagInstructionOpcodeEnum];
  reg[4:0]instructionRegister;
  JtagInstructionOpcodeEnum jtagInstructionOpcode;
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_SlaveDRIVER_BFM"; 

   task waitForReset();
    jtagTapState = jtagResetState;
  endtask : waitForReset


task registeringData(reg[4:0]instructionRegister , logic dataIn);
       for (int i=0;i<(jtagInstructionOpcode.num()) ;i++) begin 
        if(jtagInstructionOpcode == instructionRegister) begin
	  if(instructionRegister == jtagInstructionOpcode.first()) 
	   begin 
               byPassRegister = dataIn;
	      jtagSerialOut  = byPassRegister ;
	   end 
	 else begin 
	  registerBank[instructionRegister] = {dataIn,registerBank[instructionRegister][(JTAGREGISTERWIDTH -1):1] };
	   jtagSerialOut = registerBank[instructionRegister][0];
	  $display("### TARGET DRIVER ### THE SERIAL DATA %b FROM CONTROLLER DRIVER IS STORED IN REG WHOSE VECTOR IS %b AT %0t \n",dataIn,registerBank[instructionRegister],$time);
	  break;
	  end 
        end 
	else begin
	  jtagInstructionOpcode = jtagInstructionOpcode.next();
        end 
      end 
endtask 
task observeData();
  int  i,k ,m;
    for(int j=0 ; j< 61;j++)
      begin
        @(posedge clk);

        case(jtagTapState)

          jtagResetState :begin 
          
	    if(jtagTms == 1) begin 
	      jtagTapState = jtagResetState;
	    end 
	    else if(jtagTms ==0) begin 
	      jtagTapState = jtagIdleState;
	    end 
	  end


	  jtagIdleState : begin 
	   
	   if(jtagTms ==0) begin 
             jtagTapState = jtagIdleState;
	   end 
	   else if(jtagTms == 1) begin 
             jtagTapState = jtagDrScanState;
	   end 
	  end


          jtagDrScanState : begin 
	   
	   if(jtagTms == 1) begin 
             jtagTapState = jtagIrScanState;
	   end
	   else if(jtagTms == 0) begin 
             jtagTapState = jtagCaptureDrState;
	   end
	  end 

	  
	  jtagCaptureDrState : begin 
	    
	    if(jtagTms == 1) begin 
             jtagTapState = jtagExit1DrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagShiftDrState;
	    end 
	  end 

	  
	  jtagShiftDrState : begin 
	    $display("### TARGET DRIVER ### IS IN SHIFT DR STATE AT %0t\n",$time);
	    if(jtagTms ==1) begin
              jtagTapState = jtagExit1DrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagShiftDrState;      
	    end
	    registeringData(instructionRegister,jtagSerialIn);
	  end 
          
	  
	  jtagExit1DrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagPauseDrState;
	    end 
	  end 
          

          jtagPauseDrState : begin 
	    
	    if(jtagTms ==1) begin 
              jtagTapState = jtagExit2DrState;
 	    end 
	    else if(jtagTms ==0) begin
              jtagTapState = jtagPauseDrState;
	    end 
	  end 


          jtagExit2DrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
 	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftDrState;
            end 
	  end 

	  jtagUpdateDrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagDrScanState;
	    end  
	    else if(jtagTms == 0) begin 
	      jtagTapState = jtagIdleState;
	    end 
	  end 

	  jtagIrScanState : begin 
	    
            if(jtagTms == 1) begin 
	      jtagTapState = jtagResetState;
            end 
	    else if(jtagTms ==0) begin 
              jtagTapState = jtagCaptureIrState;
	    end
	  end 

	  jtagCaptureIrState : begin 

	    if(jtagTms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftIrState;
	    end 
            instructionRegister = 'b 00010;
	  end 


	  jtagShiftIrState : begin 
            $display("### TARGET DRIVER ### IS IN SHIFT IR STATE AT %0t \n",$time);
	    if(jtagTms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagShiftIrState ;
	    end
            instructionRegister = {jtagSerialIn,instructionRegister[4:1]};
	    $display("### TARGET DRIVER ### THE INSTRUCTION BIT OBTAINED HERE IS %b COMPLETE VECTOR IS %b AT %0t \n",jtagSerialIn,instructionRegister,$time);
	  end 
 
          jtagExit1IrState : begin 
            
 	    if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateIrState ;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagPauseIrState;
	    end 
	  end 


	  jtagPauseIrState : begin 
  
            if(jtagTms == 1) begin 
              jtagTapState = jtagExit2IrState;
	    end 
	    else if(jtagTms == 0) begin 
              jtagTapState = jtagPauseIrState;
	    end
	  end 

	  jtagExit2IrState : begin 
      
            if(jtagTms ==0) begin 
              jtagTapState = jtagShiftIrState;
	    end 
	    else if(jtagTms == 1) begin 
              jtagTapState = jtagUpdateIrState;
	    end 
	  end

	  jtagUpdateIrState: begin 
            
	    if(jtagTms == 1) begin 
	      jtagTapState = jtagDrScanState;
            end
	    else if(jtagTms == 0) begin 
               jtagTapState = jtagIdleState;
	    end
	  end 
          
	endcase  
	//$display("THE STATE in slave IS %s @%t instruction is %b and serial out is %0b",jtagTapState.name(),$time,instructionRegister,jtagSerialOut);
      end  
  endtask : observeData

  
  

	
endinterface : JtagSlaveDriverBfm
