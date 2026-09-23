module main

import os
import readline
import lexer
import parser
import ast

fn main() {
	// Create the input with the given arguments
	// Ignore the first one as it's the program's name
	if os.args.len > 1 {
		mut l := lexer.Lexer.new()
		args := os.args[1..].join(' ')

		tokens := l.tokenize(args)
		mut p := parser.Parser.new(tokens)

		node := p.parse() or {
			eprintln(err)
			return
		}

		result := ast.evaluate(node) or {
			eprintln(err)
			return
		}

		println('Result: ${result}')
		return
	}

	// If no arguments where given, move to the Read-Eval-Print Loop
	println('--- Calc RELP, write `exit` (or use Ctrl+C) to exit ---')
	for {
		mut l := lexer.Lexer.new()
		mut r := readline.Readline{
			skip_empty: true
		}
		input := r.read_line('>>> ')!

		if input == 'exit' {
			break
		}

		if input.is_blank() {
			continue
		}

		tokens := l.tokenize(input)
		mut p := parser.Parser.new(tokens)

		node := p.parse() or {
			eprintln(err)
			continue
		}

		result := ast.evaluate(node) or {
			eprintln(err)
			continue
		}

		println('Result: ${result}')
	}
}
