module Coat
  class Compiler

    attr_reader :code
    attr_reader :parsed
    attr_reader :parser
    attr_reader :contract

    def initialize
      @code = nil
      @parsed= false
      @parser = nil
      @contract = nil
    end

    def read_from_stdout(kode)
      @code = kode
    end

    def compile
      @parser = Coat::Parser.new
      @ast = @parser.parse(code)

      @parsed= true
      @contract = Coat::Contract.new(@ast.first)
    end

  end
end
