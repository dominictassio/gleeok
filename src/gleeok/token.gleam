import gleam/float
import nibble/lexer

pub type Token =
  lexer.Token(TokenType)

pub type TokenType {
  LeftParen
  RightParen
  LeftBrace
  RightBrace
  Comma
  Dot
  Minus
  Plus
  Semicolon
  Slash
  Star

  BangEqual
  Bang
  EqualEqual
  Equal
  GreaterEqual
  Greater
  LessEqual
  Less

  Identifier(String)
  String(String)
  Number(Float)

  And
  Class
  Else
  False
  Fun
  For
  If
  Nil
  Or
  Print
  Return
  Super
  This
  True
  Var
  While
}

pub fn to_string(token_type: TokenType) -> String {
  case token_type {
    LeftParen -> "LEFT_PAREN"
    RightParen -> "RIGHT_PAREN"
    LeftBrace -> "LEFT_BRACE"
    RightBrace -> "RIGHT_BRACE"
    Comma -> "COMMA"
    Dot -> "DOT"
    Minus -> "MINUS"
    Plus -> "PLUS"
    Semicolon -> "SEMICOLON"
    Slash -> "SLASH"
    Star -> "STAR"

    BangEqual -> "BANG_EQUAL"
    Bang -> "BANG"
    EqualEqual -> "EQUAL_EQUAL"
    Equal -> "EQUAL"
    GreaterEqual -> "GREATER_EQUAL"
    Greater -> "GREATER"
    LessEqual -> "LESS_EQUAL"
    Less -> "LESS"

    Identifier(name) -> "IDENTIFIER " <> name
    String(string) -> "STRING " <> string
    Number(number) -> "NUMBER " <> float.to_string(number)

    And -> "AND"
    Class -> "CLASS"
    Else -> "ELSE"
    False -> "FALSE"
    Fun -> "FUN"
    For -> "FOR"
    If -> "IF"
    Nil -> "NIL"
    Or -> "OR"
    Print -> "PRINT"
    Return -> "RETURN"
    Super -> "SUPER"
    This -> "THIS"
    True -> "TRUE"
    Var -> "VAR"
    While -> "WHILE"
  }
}
