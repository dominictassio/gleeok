import gleam/list
import gleam/option.{None, Some}
import gleeok/ast.{type Expr}
import gleeok/ast/expr
import gleeok/literal
import gleeok/token.{type TokenType}
import nibble
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
  use expr <- nibble.do(parse_comparison())
  use rights <- nibble.do(nibble.many(parse_equality_helper()))
  nibble.return({
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
  nibble.one_of([
    parse_true(),
    parse_false(),
    parse_nil(),
    parse_number_or_string(),
    parse_grouping(),
  ])
}

fn parse_true() -> Parser(Expr) {
  use _ <- nibble.do(nibble.token(token.True))
  nibble.return(expr.Literal(literal.Bool(True)))
}

fn parse_false() -> Parser(Expr) {
  use _ <- nibble.do(nibble.token(token.False))
  nibble.return(expr.Literal(literal.Bool(False)))
}

fn parse_nil() -> Parser(Expr) {
  use _ <- nibble.do(nibble.token(token.Nil))
  nibble.return(expr.Literal(literal.Nil))
}

fn parse_number_or_string() -> Parser(Expr) {
  use token <- nibble.take_map("expect number or string")
  case token {
    token.Number(n) -> Some(expr.Literal(literal.Number(n)))
    token.String(s) -> Some(expr.Literal(literal.String(s)))
    _ -> None
  }
}

fn parse_grouping() -> Parser(Expr) {
  use _ <- nibble.do(nibble.token(token.LeftParen))
  use expr <- nibble.do(parse_expression())
  use _ <- nibble.do(nibble.token(token.RightParen))
  nibble.return(expr.Grouping(expr))
}
