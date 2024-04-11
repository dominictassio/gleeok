import argv
import gleeok/lexer
import gleeok/token
import gleam/erlang
import gleam/io
import gleam/list
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
  use token <- list.each(tokens)
  token.value
  |> token.to_string
  |> io.println
}
