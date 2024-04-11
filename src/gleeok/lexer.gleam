import gleeok/token.{type Token, type TokenType}
import gleam/int
import gleam/set
import nibble/lexer

pub type Lexer =
  lexer.Lexer(TokenType, Nil)

pub type Error =
  lexer.Error

pub fn new() -> Lexer {
  lexer.simple([
    lexer.whitespace(Nil)
      |> lexer.ignore,
    lexer.comment("//", fn(_) { Nil })
      |> lexer.ignore,
    // literals
    lexer.number(fn(n) { token.Number(int.to_float(n)) }, token.Number),
    lexer.string("\"", token.String),
    // Punctuation
    lexer.token("(", token.LeftParen),
    lexer.token(")", token.RightParen),
    lexer.token("{", token.LeftBrace),
    lexer.token("}", token.RightBrace),
    lexer.token(",", token.Comma),
    lexer.token(".", token.Dot),
    lexer.token(";", token.Semicolon),
    // operators
    lexer.token("-", token.Minus),
    lexer.token("+", token.Plus),
    lexer.token("/", token.Slash),
    lexer.token("*", token.Star),
    lexer.token("!=", token.BangEqual),
    lexer.token("!", token.Bang),
    lexer.token("==", token.EqualEqual),
    lexer.token("=", token.Equal),
    lexer.token(">=", token.GreaterEqual),
    lexer.token(">", token.Greater),
    lexer.token("<=", token.LessEqual),
    lexer.token("<", token.Less),
    // keywords
    lexer.keyword("and", "[^0-9A-Za-z_]", token.And),
    lexer.keyword("class", "[^0-9A-Za-z_]", token.Class),
    lexer.keyword("else", "[^0-9A-Za-z_]", token.Else),
    lexer.keyword("false", "[^0-9A-Za-z_]", token.False),
    lexer.keyword("fun", "[^0-9A-Za-z_]", token.Fun),
    lexer.keyword("for", "[^0-9A-Za-z_]", token.For),
    lexer.keyword("if", "[^0-9A-Za-z_]", token.If),
    lexer.keyword("nil", "[^0-9A-Za-z_]", token.Nil),
    lexer.keyword("or", "[^0-9A-Za-z_]", token.Or),
    lexer.keyword("print", "[^0-9A-Za-z_]", token.Print),
    lexer.keyword("return", "[^0-9A-Za-z_]", token.Return),
    lexer.keyword("super", "[^0-9A-Za-z_]", token.Super),
    lexer.keyword("this", "[^0-9A-Za-z_]", token.This),
    lexer.keyword("true", "[^0-9A-Za-z_]", token.True),
    lexer.keyword("var", "[^0-9A-Za-z_]", token.Var),
    lexer.keyword("while", "[^0-9A-Za-z_]", token.While),
    // identifiers
    lexer.identifier("[A-Za-z_]", "[0-9A-Za-z_]", set.new(), token.Identifier),
  ])
}

pub fn run(lexer: Lexer, source: String) -> Result(List(Token), Error) {
  lexer.run(source, lexer)
}
