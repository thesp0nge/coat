require 'spec_helper'

describe "Coat lexer" do
  let (:lexer) {Coat::Lexer.new}
  it "can be created" do
    lexer.should_not be_nil
  end


  it "must recognize a number" do
    lexer.tokenize("1").should =~ [[:NUMBER, 1]]
  end

  it "must recognize a string literal" do
    lexer.tokenize('"test"').should =~ [[:STRING, "test"]]
  end
    
  it "must recognize an identifier" do
    lexer.tokenize('name').should =~ [[:IDENTIFIER, "name"]]
  end
  
  it "must recognize a constant" do
    lexer.tokenize('Test').should =~ [[:CONSTANT, "Test"]]
  end

  it "must recognize an indented empty statement" do
code= <<-CODE
:
  ;
CODE
    tokens = [
      [:INDENT, 2], [";", ";"], [:DEDENT, 0]
    ]
    lexer.tokenize(code).should =~ tokens
  end

  it "must recognize an empty contract" do
code=<<-CODE
contract Test:
  ;
CODE
    tokens=[
      [:CONTRACT, "contract"], [:CONSTANT, "Test"],
      [:INDENT, 2], [";", ";"], [:DEDENT, 0]
    ]
    lexer.tokenize(code).should =~ tokens

  end

  it "must recognize the hello world contract " do
code= <<-CODE
contract HelloWorld:
  pre:
    none
  post:
    read "Hello world" from stdout
  api:
    def say_hello:
      pre:
        none
      post:
        "Hello world"
CODE
    tokens = [
      [:CONTRACT, "contract"], [:CONSTANT, "HelloWorld"],
      [:INDENT, 2], [:PRE, "pre"],
      [:INDENT, 4], [:NONE, "none"], [:DEDENT, 2], [:NEWLINE, "\n"],
      [:POST, "post"],
      [:INDENT, 4], [:READ, "read"], [:STRING, "Hello world"], [:FROM, "from"], [:STDOUT, "stdout"], [:DEDENT, 2], [:NEWLINE, "\n"],
      [:API, "api"],
      [:INDENT, 4], [:DEF, "def"], [:IDENTIFIER, "say_hello"],
      [:INDENT, 6], [:PRE, "pre"],
      [:INDENT, 8], [:NONE, "none"], [:DEDENT, 6], [:NEWLINE, "\n"],
      [:POST, "post"],
      [:INDENT, 8], [:STRING, "Hello world"], [:DEDENT, 2], [:DEDENT, 2], [:DEDENT, 2], [:DEDENT, 0]
    ]
    lexer.tokenize(code).should =~ tokens
  end

end
