require 'spec_helper'

describe "Coat parser" do
  let (:parser) {Coat::Parser.new}
  it "can be created" do
    parser.should_not be_nil
  end
end
