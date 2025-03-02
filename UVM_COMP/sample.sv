`include "uvm_macros.svh"
import uvm_pkg::*; 
class sample extends uvm_component;
`uvm_component_utils(sample)
  function new(string path = "sample", uvm_component parent= null );
super.new(path,parent);
endfunction
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("comp","build_phase", UVM_NONE);
endfunction
endclass
module tb;

initial begin
  run_test("sample");//once we started working in phases run_test can beused where the factory will take care of everything for that class mentioned
end
endmodule
