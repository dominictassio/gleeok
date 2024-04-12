import gleam/float

pub type Literal {
  Bool(Bool)
  Nil
  Number(Float)
  String(String)
}

pub fn to_string(literal: Literal) -> String {
  case literal {
    Bool(True) -> "true"
    Bool(False) -> "false"
    Nil -> "nil"
    Number(n) -> float.to_string(n)
    String(s) -> "\"" <> s <> "\""
  }
}
