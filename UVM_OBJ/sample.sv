`include "uvm_macros.svh"
import uvm_pkg::*; 
class sample exyends uvm_object;
`uvm_object_utils(sample)
function new(string path = "sample");
super.new(path);
endfunction
rand int a;
endclass
module tb;
sample s;
initial begin
s=new();
s.randomize();
`uvm_info("TB", $sformatf("the value of a: %0d", o.a),UVM_NONE);
end
endmodule
