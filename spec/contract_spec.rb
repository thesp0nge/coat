require 'spec_helper'

describe "An HelloWorld coat contract" do
  before (:all) do

@hello= <<-CODE
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
    compiler = Coat::Compiler.new
    compiler.read_from_stdout(@hello)
    @contract=compiler.compile
  end

  it "can be create" do
    @contract.should_not be_nil
  end

  it "must be named HelloWorld" do
    @contract.name.should == "HelloWorld"
  end

  it "must convert its name to filename using ruby convention" do
    @contract.filename.should == "hello_world"
  end
end
