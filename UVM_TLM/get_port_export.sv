// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;
class producer extends uvm_component;
  `uvm_component_utils(producer)
  int d=0;
  uvm_blocking_get_port#(int) recv;
  function new ( string path = "producer", uvm_component parent= null);
    super.new(path,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv= new("recv",this);
  endfunction
  task main_phase(uvm_phase phase);
    recv.get(d);
    `uvm_info("[prod]",$sformatf("data recv: %0d", d), UVM_NONE);
  endtask
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  int data=5;
  uvm_blocking_get_imp#(int,consumer) send;
  function new( string path= "consumer", uvm_component parent= null);
    super.new(path,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    send=new("send",this);
  endfunction
  virtual task get(output int datar);
  datar=data;
    `uvm_info("[consumer]",$sformatf("data sent: %0d", data), UVM_NONE);
  endtask
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string path= "env", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  producer p;
  consumer c;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p=producer::type_id::create("p",this);
    c=consumer::type_id::create("c",this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.recv.connect(c.send);
  endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  env e;
   function new(input string inst = "test", uvm_component c);
super.new(inst, c);
endfunction
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e = env::type_id::create("e",this);
endfunction
endclass
 
 
//////////////////////////////////////////////////
module tb;
  
  initial begin
    run_test("test");
  end
endmodule
