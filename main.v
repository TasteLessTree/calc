module main

import lexer
import parser
import ast

fn main() {
	input := '27 + (420 / 10)'
	l := lexer.Lexer.new()

	tokens := l.tokenize(input)

	// println(tokens)
	// println('Tokens len ${tokens.len}')

	mut p := parser.Parser.new(tokens)
	node := p.parse() or {
		println(err)
		return
	}

	result := ast.evaluate(node) or {
		println(err)
		return
	}

	println('Input: ${input}')
	println(result)
	ast.print_ast(node, 0)
}
