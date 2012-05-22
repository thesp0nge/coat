require 'spec_helper'

describe "A valid coat program" do
  before(:all) do
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
      @compiler = Coat::Compiler.new
      @compiler.read_from_stdout(@hello)
      @compiler.compile
    end

  describe "compiling the hello world program" do
   
    it "should exist" do
      @compiler.nil?.should be_false
    end

    it "should have a code" do
      @compiler.code.should == @hello
    end
    it "should have parsed the code" do
      @compiler.parsed.should be_true
      @compiler.parser.should_not be_nil
    end
   end

  describe "must cause the compiler" do  
    it "to extract an HelloWorld named contract" do
      @compiler.contract.name.should == "HelloWorld"
    end

    it "to create an hello_world.rb file" do
      File.exists?('hello_world.rb').should be_true
    end
  end
end
