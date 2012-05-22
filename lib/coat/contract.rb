module Coat
  class Contract

    attr_reader :name
    attr_reader :filename

    def initialize(root)
      error = false
      
      if ! root.nil?
        @name = root.first.name
      end
      @filename = @name.underscore

    end

    def create_ruby_file

    end

    def create_spec_file

    end

  end
end
