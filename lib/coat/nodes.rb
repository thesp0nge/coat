# Collection of nodes each one representing an expression.
class Nodes < Struct.new(:nodes)
  def <<(node)
    nodes << node
    self
  end
end

# Literals are static values that have a Ruby representation, eg.: a string, a number, 
# true, false, nil, etc.
class LiteralNode < Struct.new(:value); end
class NumberNode < LiteralNode; end
class StringNode < LiteralNode; end
class TrueNode < LiteralNode
  def initialize
    super(true)
  end
end
class FalseNode < LiteralNode
  def initialize
    super(false)
  end
end
class NilNode < LiteralNode
  def initialize
    super(nil)
  end
end

# Retrieving the value of a constant.
class GetConstantNode < Struct.new(:name); end

# Setting the value of a constant.
class SetConstantNode < Struct.new(:name, :value); end

# Contract definition.
class ContractNode < Struct.new(:name, :body); end

# Api definition
class ApiNode < Struct.new(:name, :body); end

# Pre conditions
class PreNode < Struct.new(:body); end

# Post conditions
class PostNode < Struct.new(:body); end
