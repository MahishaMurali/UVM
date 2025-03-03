// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;
class sub_producer extends uvm_component;
  `uvm_component_utils(sub_producer)
  uvm_blocking_put_port#(int) sub_port;
  int d=10;
  function new( string path= " sub_producer", uvm_component parent= null);
    super.new(path,parent);
  endfunction
   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     sub_port = new("sub_port",this);
  endfunction
  task main_phase(uvm_phase phase);
    sub_port.put(d);
    `uvm_info("[sub_prod]",$sformatf("data sent: %0d", d), UVM_NONE);
  endtask
endclass

class producer extends uvm_component;
  `uvm_component_utils(producer)
   sub_producer sb;
  uvm_blocking_put_port#(int) send;
  function new ( string path = "producer", uvm_component parent= null);
    super.new(path,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    send= new("send",this);
    sb=sub_producer::type_id::create("sb", this);
  endfunction
  virtual function void connect_phase put(uvm_phase phase);
    super.connect_phase(phase);
    sb.sub_port.connect(send);
  endfunction
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  uvm_blocking_put_imp#(int,consumer) impl;
  function new( string path= "consumer", uvm_component parent= null);
    super.new(path,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    impl=new("impl",this);
  endfunction
  function void put( int dr);
    `uvm_info("[cons]",$sformatf("data resvd: %0d", dr), UVM_NONE);
  endfunction
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
    p.send.connect(c.impl);
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
