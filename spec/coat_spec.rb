require 'spec_helper'

describe "A valid coat program is" do

  ## An empty code program is parsed but no nodes are returned.
  it "a program with the only ';' identifier" do
    code = ";"
    node =  Nodes.new([])

    Coat::Parser.new.parse(code) == node
  end

  it "a program with an empty contract" do
    code = <<-CODE 
contract TestContract:
  ;
CODE
    node = Nodes.new([ContractNode.new("TestContract")])

    Coat::Parser.new.parse(code) =~ node
  end

  it "the hello world program" do
    fail "you must write it"
  end
end
