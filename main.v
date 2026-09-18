module main

import lexer

fn main() {
	input := '27 + (420 / 10)'
	l := lexer.Lexer.new()

	tokens := l.tokenize(input)

	println(tokens)
	println('Tokens len ${tokens.len}')
}
