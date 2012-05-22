module Coat
  class Contract

    attr_reader :name

    def initialize(root)
      error = false
      
      if ! root.nil?
        @name = root.first.name
      end

    end
  end
end
