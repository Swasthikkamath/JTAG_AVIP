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
 
  typedef enum bit {noInstructoion = 0 ,
                    yesInstruction =1} JtagInstructionFlagEnum;
  
  typedef enum bit[4:0] {bypassRegister = 5'b 0000}JtagInstructionOpcodeEnum;


endpackage : JtagGlobalPkg
`endif
