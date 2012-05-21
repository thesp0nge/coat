class Coat::Parser
#
# Declare tokens produced by the lexer
token PRE
token CONTRACT
token DEF
token POST
token NEWLINE
token NUMBER
token STRING
token READ
token FROM
token WRITE
token TO
token STDERR
token STDOUT
token API
token IDENTIFIER
token CONSTANT
token INDENT DEDENT
token TRUE FALSE NIL NONE

rule
  # All rules are declared in this format:
  #
  #   RuleName:
  #     OtherRule TOKEN AnotherRule    { code to run when this matches }
  #   | OtherRule                      { ... }
  #   ;
  #
  # In the code section (inside the {...} on the right):
  # - Assign to "result" the value returned by the rule.
  # - Use val[index of expression] to reference expressions on the left.
  
  
  # All parsing will end in this rule, being the trunk of the AST.
  Root:
    /* nothing */                      { result = Nodes.new([]) }
  | Expressions                        { result = val[0] }
  ;
  
  # Any list of expressions, class or method body, seperated by line breaks.
  Expressions:
    Expression                         { result = Nodes.new(val) }
  | Expressions Terminator Expression  { result = val[0] << val[2] }
    # To ignore trailing line breaks
  | Expressions Terminator             { result = val[0] }
  | Terminator                         { result = Nodes.new([]) }
  ;

  # All types of expressions in our language
  Expression:
    Literal
  | Contract
  | Api
  | Constant
  | Read
  | Write
  | Pre
  | Post
  | Def
  | '(' Expression ')'    { result = val[1] }
  ;
  
  # All tokens that can terminate an expression
  Terminator:
    NEWLINE
  | ";"
  ;
  
  # All hard-coded values
  Literal:
    NUMBER                        { result = NumberNode.new(val[0]) }
  | STRING                        { result = StringNode.new(val[0]) }
  | TRUE                          { result = TrueNode.new }
  | FALSE                         { result = FalseNode.new }
  | NIL                           { result = NilNode.new }
  | NONE                          { result = NoneNode.new }
  ;
  
  Read:
    READ Literal FROM STDOUT      { result = ReadNode.new(val[1]) } # reading from files will be handled later...
  ;

  Write:
    WRITE Literal TO STDOUT       { result = WriteNode.new(val[1]) }
  ;
  # The contract definition
  Contract:
    CONTRACT CONSTANT Block       { result = ContractNode.new(val[1], val[2]) }
  ;
  
  Api:
    API Block                     { result = ApiNode.new(val[1], val[2]) }
  ;

  Constant:
    CONSTANT                      { result = GetConstantNode.new(val[0]) }
  ;

  Pre:
    PRE Block                     { result = PreNode.new(val[1]) }
  ;

  Post:
    POST Block                    { result = PostNode.new(val[1]) }
  ;
  
  Def: 
    DEF IDENTIFIER Block          { result = DefNode.new(val[1], val[2]) }
  ;
  
  # A block of indented code. You see here that all the hard work was done by the
  # lexer.
  Block:
    INDENT Expressions DEDENT     { result = val[1] }
  # If you don't like indentation you could replace the previous rule with the 
  # following one to separate blocks w/ curly brackets. You'll also need to remove the
  # indentation magic section in the lexer.
  # "{" Expressions "}"           { replace = val[1] }
  ;
end

---- header
  require "coat/lexer"
  require "coat/nodes"

---- inner
  # This code will be put as-is in the Parser class.
  def parse(code, show_tokens=false)
    @tokens = Lexer.new.tokenize(code) # Tokenize the code using our lexer
    puts @tokens.inspect if show_tokens
    do_parse # Kickoff the parsing process
  end
  
  def next_token
    @tokens.shift
  end
