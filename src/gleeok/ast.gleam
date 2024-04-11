import gleeok/literal.{type Literal}
import gleeok/token.{type Token}
import gleam/option.{type Option}

pub type Expression {
  Assign(name: String, value: Expression)
  Binary(left: Expression, operator: Token, right: Expression)
  Call(callee: Expression, paren: Token, arguments: List(Expression))
  Get(object: Expression, name: Token)
  Grouping(Expression)
  Literal(Literal)
  Logical(left: Expression, operator: Token, right: Expression)
  Set(object: Expression, name: Token, value: Expression)
  Super(keyword: Token, method: Token)
  This(keyword: Token)
  Unary(operator: Token, right: Expression)
  Variable(name: Token)
}

pub type Function {
  Fun(name: Token, params: List(Token), body: List(Statement))
}

pub type Statement {
  Block(List(Statement))
  Class(name: Token, base: Token, methods: List(Function))
  Expression(Expression)
  Function(Function)
  If(condition: Expression, consequent: Statement, alternative: Statement)
  Print(Expression)
  Return(keyword: Token, value: Option(Expression))
  Var(name: Token, initializer: Option(Expression))
  While(condition: Expression, body: Statement)
}
