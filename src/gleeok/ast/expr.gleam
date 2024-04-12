import gleeok/literal.{type Literal}
import gleeok/token.{type TokenType}
import gleam/string
import nibble/lexer.{type Span}

pub type Expr {
  Assign(name: String, value: Expr)
  Binary(left: Expr, operator: #(TokenType, Span), right: Expr)
  Call(callee: Expr, paren: #(TokenType, Span), arguments: List(Expr))
  Get(object: Expr, name: #(TokenType, Span))
  Grouping(Expr)
  Literal(Literal)
  Logical(left: Expr, operator: #(TokenType, Span), right: Expr)
  Set(object: Expr, name: #(TokenType, Span), value: Expr)
  Super(keyword: #(TokenType, Span), method: #(TokenType, Span))
  This(keyword: #(TokenType, Span))
  Unary(operator: #(TokenType, Span), right: Expr)
  Variable(name: #(TokenType, Span))
}

pub fn to_string(expr: Expr) -> String {
  "("
  <> case expr {
    Assign(name, value) ->
      string.join(["assign", name, to_string(value)], with: " ")
    Binary(left, #(tt, _), right) ->
      string.join(
        [token.to_string(tt), to_string(left), to_string(right)],
        with: " ",
      )
    Grouping(expr) -> string.join(["grouping", to_string(expr)], with: "")
    Literal(lit) -> literal.to_string(lit)
    _ -> "<unknown>"
  }
  <> ")"
}
