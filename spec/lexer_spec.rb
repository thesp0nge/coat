require 'spec_helper'

describe "Coat lexer" do
  it "must recognize a number" do
    token = [[:NUMBER, 1]]
    result= Coat::Lexer.new.tokenize("1")

    result.should =~ token
  end

end
