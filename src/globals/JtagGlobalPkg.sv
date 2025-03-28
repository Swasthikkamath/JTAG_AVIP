`ifndef JTAGGLOBALPKG_INCLUDED_
`define JTAGGLOBALPKG_INCLUDED_

package JtagGlobalPkg;
  
  
  typedef enum bit [5:0]{testVectorWidth8Bit= 8,
                         testVectorWidth16Bit = 16,
			 testVectorWidth24Bit = 24 , 
			 testVectorWidth32Bit=32} JtagTestVectorWidthEnum;
  
  typedef enum bit [2:0]{instructionWidth3Bit= 3,
                         instructionWidth4Bit = 4,
			 instructionWidth5Bit = 5} JtagInstructionWidthEnum;
 
  typedef enum bit[4:0] {bypassRegister = 5'b 00000,
                         userDefinedRegister = 5'b 00001, 
			 boundaryScanRegisters=5'b 00110 }JtagInstructionOpcodeEnum;

  typedef struct packed {JtagTestVectorWidthEnum jtagTestVectorWidth;
                         JtagInstructionWidthEnum jtagInstructionWidth;
			 logic[4:0] jtagInstructionOpcode;}JtagConfigStruct;
 
 
  typedef struct packed{logic[61:0] jtagTestVector; logic[4:0]jtagInstruction; logic[31:0]jtagTms;}JtagPacketStruct;

  typedef enum{jtagResetState ,jtagIdleState,jtagDrScanState, jtagIrScanState,jtagCaptureIrState,jtagShiftIrState,jtagExit1IrState,jtagPauseIrState,jtagExit2IrState,jtagUpdateIrState,jtagCaptureDrState,jtagShiftDrState,jtagExit1DrState,jtagPauseDrState,jtagExit2DrState,jtagUpdateDrState}JtagTapStates;
endpackage : JtagGlobalPkg
`endif
