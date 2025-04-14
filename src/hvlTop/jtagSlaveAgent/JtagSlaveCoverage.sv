`ifndef JTAGSLAVECOVERAGE_INCLUDED_
`define JTAGSLAVECOVERAGE_INCLUDED_

class JtagSlaveCoverage extends uvm_subscriber#(JtagSlaveTransaction);
  `uvm_component_utils(JtagSlaveCoverage)
  
  bit[31:0] testVector;
  JtagSlaveAgentConfig jtagSlaveAgentConfig;
  int j;
  extern function new(string name = "JtagSlaveCoverage",uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void write(JtagSlaveTransaction t);

  covergroup JtagSlaveCoverGroup with function sample(bit[31:0]TDO , JtagSlaveAgentConfig jtagSlaveAgentConfig);
   JtagTestVector_CP : coverpoint TDO{ bins low_range = {[0:(2**12)]};
                                                  bins mid_range = {[(2**12)+1 : 2**24]} ;
		                                bins high_range = {[(2**24)+1 : 0]};}
   		
   JTAG_TESTVECTOR_WIDTH : coverpoint jtagSlaveAgentConfig.jtagTestVectorWidth{ bins TDO_WIDTH_8 = {testVectorWidth8Bit};
                                                                                 bins TDO_WIDTH_16 = {testVectorWidth16Bit};
										 bins TDO_WIDTH_24 = {testVectorWidth24Bit};
									         bins TDI_WIDTH_32 = {testVectorWidth32Bit};
										}
   JTAG_INSTRUCTION_WIDTH:coverpoint jtagSlaveAgentConfig.jtagInstructionWidth{ bins INSTRUCTION_WIDTH_3 = {instructionWidth3Bit};
                                                                                 bins INSTRUCTION_WIDTH_4 = {instructionWidth4Bit};
										 bins INSTRUCTION_WIDTH_5 = {instructionWidth5Bit};
   										    }	
   JTAG_INSTRUCTION : coverpoint jtagSlaveAgentConfig.jtagInstructionOpcode;


   TARGETDATA_PATTERN_8 : coverpoint TDO{
      bins Target_pattern1_8 = {8'b 11111111};
      bins Target_pattern2_8 = {8'b 10101010};
      bins Target_pattern3_8 = {8'b 11110000};
      bins Target_pattern4_8 = {8'b 00000000};
      bins Target_pattern5_8 = {8'b 01010101};}

      TARGETDATA_PATTERN_16 : coverpoint TDO{
      bins Target_pattern1_16 = {16'b 1111111111111111};
	      bins Target_pattern2_16 = {16'b 1010101010101010};
	      bins Target_pattern3_16 = {16'b 1111000011110000};
	      bins Target_pattern4_16 = {16'b 0000000000000000};
	      bins Target_pattern5_16 = {16'b 0101010101010101};}


      TARGETDATA_PATTERN_24 : coverpoint TDO{
	      bins Target_pattern1_24 = {24'b 111111111111111111111111};
	      bins Target_pattern2_24 = {24'b 101010101010101010101010};
	      bins Target_pattern3_24 = {24'b 111100001111000011110000};
	      bins Target_pattern4_24 = {24'b 000000000000000000000000};
	      bins Target_pattern5_24 = {24'b 010101010101010101010101};}

      TARGETDATA_PATTERN_32 : coverpoint TDO{
	      bins Target_pattern1_32 = {32'b 11111111111111111111111111111111};
	      bins Target_pattern2_32 = {32'b 10101010101010101010101010101010};
	      bins Target_pattern3_32 = {32'b 11110000111100001111000011110000};
	      bins Target_pattern4_32 = {32'b 00000000000000000000000000000000};
	      bins Target_pattern5_32 = {32'b 01010101010101010101010101010101};}
       

	  DATA_PATTERN_5_DATA_WIDTH_CP : cross TARGETDATA_PATTERN_8,JTAG_TESTVECTOR_WIDTH { ignore_bins data_8 =  !binsof(JTAG_TESTVECTOR_WIDTH)intersect{testVectorWidth8Bit};}
	  DATA_PATTERN_6_DATA_WIDTH_CP : cross TARGETDATA_PATTERN_16,JTAG_TESTVECTOR_WIDTH { ignore_bins data_16 =  !binsof(JTAG_TESTVECTOR_WIDTH) intersect{testVectorWidth16Bit};}
	  DATA_PATTERN_7_DATA_WIDTH_CP : cross TARGETDATA_PATTERN_24,JTAG_TESTVECTOR_WIDTH { ignore_bins data_24 =  !binsof(JTAG_TESTVECTOR_WIDTH) intersect {testVectorWidth24Bit};}
	  DATA_PATTERN_8_DATA_WIDTH_CP : cross TARGETDATA_PATTERN_32,JTAG_TESTVECTOR_WIDTH { ignore_bins data_32 =  !binsof(JTAG_TESTVECTOR_WIDTH) intersect{testVectorWidth32Bit};}

  endgroup

endclass : JtagSlaveCoverage

function JtagSlaveCoverage :: new(string name= "JtagSlaveCoverage",uvm_component parent);
 super.new(name,parent);
  JtagSlaveCoverGroup = new();
endfunction : new

function void JtagSlaveCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db #(JtagSlaveAgentConfig) :: get(this,"","jtagSlaveAgentConfig",jtagSlaveAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET Slave CONFIG IN COVERRAGE")
endfunction : build_phase

function void JtagSlaveCoverage :: write(JtagSlaveTransaction t);
  testVector =0;
    for(int i=0;i<62 ;i++)
      if(!($isunknown(t.jtagTestVector[i])))
        testVector[j++] = t.jtagTestVector[i];
  JtagSlaveCoverGroup.sample(testVector , jtagSlaveAgentConfig);
 
endfunction : write

`endif
