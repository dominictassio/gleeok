import argv
import gleeok/ast/expr
import gleeok/lexer
import gleeok/parser
import gleeok/token
import gleam/erlang
import gleam/io
import gleam/list
import nibble
import simplifile

pub fn main() {
  case argv.load().arguments {
    [path] -> run_file(path)
    [] -> run_prompt()
    _ -> io.println("Usage: gleeok [script]")
  }
}

fn run_file(path: String) {
  let assert Ok(source) = simplifile.read(from: path)
  run(source)
}

fn run_prompt() {
  case erlang.get_line("> ") {
    Error(_) -> io.println("\nbye!")
    Ok(line) -> {
      run(line)
      run_prompt()
    }
  }
}

fn run(source: String) {
  let lexer = lexer.new()
  let assert Ok(tokens) = lexer.run(lexer, source)
  let parser = parser.new()
  let result = nibble.run(tokens, parser)
  case result {
    Ok(e) ->
      expr.to_string(e)
      |> io.println
    Error(e) -> {
      io.debug(e)
      Nil
    }
  }
  Nil
}
