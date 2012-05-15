require 'spec_helper'

describe "Coat parser" do
  let (:parser) {Coat::Parser.new}
  it "can be created" do
    parser.should_not be_nil
  end
  it "must parse a number" do
    parser.parse("1").should == Nodes.new([NumberNode.new(1)])
  end
  it "must parse a string literal" do
    parser.parse('"test"').should == Nodes.new([StringNode.new("test")])
  end
    
  
end
