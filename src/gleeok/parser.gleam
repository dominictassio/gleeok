import gleeok/ast.{type Expression}
import gleeok/literal
import gleeok/token.{type Token, type TokenType}
import gleam/option.{None, Some}
import nibble.{do, one_of, return}
import nibble/lexer.{Token}
import nibble/pratt

pub type Parser(a) =
  nibble.Parser(a, Token, Nil)

pub fn new() -> Parser(Expression) {
  todo
}

fn parse_expression() -> Parser(Expression) {
  pratt.expression(
    one_of: [fn(_) { parse_primary() }],
    and_then: [],
    dropping: nibble.throw(""),
  )
}

fn parse_primary() -> Parser(Expression) {
  one_of([parse_literal(), parse_grouping()])
}

fn parse_literal() -> Parser(Expression) {
  use token: Token <- nibble.take_map("expected false")
  case token.value {
    token.True -> Some(ast.Literal(literal.Bool(True)))
    token.False -> Some(ast.Literal(literal.Bool(False)))
    token.Number(n) -> Some(ast.Literal(literal.Number(n)))
    token.String(s) -> Some(ast.Literal(literal.String(s)))
    _ -> None
  }
}

fn parse_grouping() -> Parser(Expression) {
  use _ <- do(take_if("(", token.LeftParen))
  use e <- do(parse_expression())
  use _ <- do(take_if(")", token.RightParen))
  return(e)
}

fn take_if(expecting: String, token_type: TokenType) {
  nibble.take_if("expecting (" <> expecting <> ")", fn(token: Token) {
    token.value == token_type
  })
}
