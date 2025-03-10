`include "uvm_macros.svh"
import uvm_pkg::*;
class a extends uvm_component;
`uvm_component_utils(a)
function new(string path="a", uvm_component parent = null);
super.new(path,parent);
endfunction
  virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
    `uvm_info("a", "Class a executed", UVM_NONE);
endfunction
endclass
class b extends uvm_component;
`uvm_component_utils(b)
function new(string path="b", uvm_component parent = null);
super.new(path,parent);
endfunction
  virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
    `uvm_info("b", "Class b executed", UVM_NONE);
endfunction
endclass
class c extends uvm_component;
`uvm_component_utils(c)
a a1;
b b1;
function new(string path="c", uvm_component parent = null);
super.new(path,parent);
endfunction
  virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
a1=a::type_id::create("a1",this);
b1=b::type_id::create("b1",this);
endfunction

endclass
module tb;
initial begin
run_test("c");
end
endmodule
