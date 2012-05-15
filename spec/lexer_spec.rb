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

end
