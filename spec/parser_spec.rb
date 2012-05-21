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

  it "must parse the hello world" do
code= <<-CODE
contract HelloWorld:
  pre:
    none
  post:
    write "Hello world" to stdout
  api:
    def say_hello:
      pre:
        none
      post:
        "Hello world"
CODE
    nodes = Nodes.new([
      ContractNode.new("HelloWorld", 
                       Nodes.new([
                                 PreNode.new(Nodes.new(
                                   [ NoneNode.new() ]
                                 )),
                                 PostNode.new(Nodes.new(
                                   [WriteNode.new(
                                     StringNode.new("Hello world"))]
                                 )),
                                   ApiNode.new(Nodes.new([DefNode.new("say_hello",
                                                                      Nodes.new(
                                                                        [PreNode.new(Nodes.new([NoneNode.new()])),
                                                                          PostNode.new(Nodes.new([StringNode.new("Hello world")]))
                                 ]))])
                                 )

                       ])
      )
      ])

      parser.parse(code).should == nodes
  end
    
  
end
