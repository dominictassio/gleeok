import gleeok/ast.{type Expr}
import gleeok/ast/expr
import gleeok/literal
import gleeok/token.{type TokenType}
import gleam/list
import gleam/option.{None, Some}
import nibble.{do, many, one_of, return}
import nibble/lexer.{type Span}

pub type Parser(a) =
  nibble.Parser(a, TokenType, Nil)

pub fn new() -> Parser(Expr) {
  parse_primary()
}

fn parse_expression() -> Parser(Expr) {
  parse_primary()
}

fn parse_equality() -> Parser(Expr) {
  use expr <- do(parse_comparison())
  use rights <- do(many(parse_equality_helper()))
  return({
    use expr, #(#(op, span), right) <- list.fold(rights, expr)
    expr.Binary(expr, #(op, span), right)
  })
}

fn parse_equality_helper() -> Parser(#(#(TokenType, Span), Expr)) {
  todo
  // use op <- do(
  //   one_of([take_token(token.EqualEqual, ""), take_token(token.BangEqual, "")]),
  // )
  // use right <- do(parse_comparison())
  // return(#(op, right))
}

fn parse_comparison() -> Parser(Expr) {
  todo
}

fn parse_primary() -> Parser(Expr) {
  one_of([parse_literal(), parse_grouping()])
}

fn parse_literal() -> Parser(Expr) {
  use token: TokenType <- nibble.take_map("expected primary")
  case token {
    token.True -> Some(expr.Literal(literal.Bool(True)))
    token.False -> Some(expr.Literal(literal.Bool(False)))
    token.Nil -> Some(expr.Literal(literal.Nil))
    token.Number(n) -> Some(expr.Literal(literal.Number(n)))
    token.String(s) -> Some(expr.Literal(literal.String(s)))
    _ -> None
  }
}

fn parse_grouping() -> Parser(Expr) {
  use _ <- do(nibble.token(token.LeftParen))
  use expr <- do(parse_expression())
  use _ <- do(expect_token(token.RightParen, "Expect ')' after expression."))
  return(expr.Grouping(expr))
}

fn expect_token(token_type: TokenType, message: String) -> Parser(Nil) {
  use token <- nibble.take_map(message)
  case token == token_type {
    True -> Some(Nil)
    False -> None
  }
}
