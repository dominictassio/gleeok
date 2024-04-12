import gleam/option.{type Option}
import gleeok/ast/expr.{type Expr}
import gleeok/token.{type TokenType}
import nibble/lexer.{type Span}

pub type Func {
  Func(
    name: #(TokenType, Span),
    params: List(#(TokenType, Span)),
    body: List(Stat),
  )
}

pub type Stat {
  Block(List(Stat))
  Class(name: #(TokenType, Span), base: #(TokenType, Span), methods: List(Func))
  Expression(Expr)
  Function(Func)
  If(condition: Expr, consequent: Stat, alternative: Stat)
  Print(Expr)
  Return(keyword: #(TokenType, Span), value: Option(Expr))
  Var(name: #(TokenType, Span), initializer: Option(Expr))
  While(condition: Expr, body: Stat)
}
