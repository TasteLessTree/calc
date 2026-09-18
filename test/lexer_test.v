module test

import lexer

type Token = lexer.Token

type TokenType = lexer.TokenType

fn test_tokenize_single_digit_number() {
	mut l := lexer.Lexer.new()

	input := '5'
	expected := [Token{ token_type: TokenType.num, data: input, column: 1 }]

	assert l.tokenize(input) == expected
}

fn test_tokenize_double_digit_number() {
	mut l := lexer.Lexer.new()

	input := '13'
	expected := [Token{ token_type: TokenType.num, data: input, column: 1 }]

	assert l.tokenize(input) == expected
}

fn test_tokenize_triple_digit_number() {
	mut l := lexer.Lexer.new()

	input := '420'
	expected := [Token{ token_type: TokenType.num, data: input, column: 1 }]

	assert l.tokenize(input) == expected
}

fn test_tokenize_float_number() {
	mut l := lexer.Lexer.new()

	input := '6.9'
	expected := [Token{ token_type: TokenType.num, data: input, column: 1 }]

	assert l.tokenize(input) == expected
}

fn test_tokenize_single_symbol() {
	mut l := lexer.Lexer.new()

	input := '/'
	expected := [Token{ token_type: TokenType.div, data: input, column: 1 }]

	assert l.tokenize(input) == expected
}

fn test_tokenize_symbols_and_numbers() {
	mut l := lexer.Lexer.new()

	input := '(13 + 420) / 6.9'
	expected := [Token{ token_type: TokenType.left_parent, data: '(', column: 1 },
		Token{ token_type: TokenType.num, data: '13', column: 2 },
		Token{ token_type: TokenType.plus, data: '+', column: 5 },
		Token{ token_type: TokenType.num, data: '420', column: 7 },
		Token{ token_type: TokenType.right_parent, data: ')', column: 10 },
		Token{ token_type: TokenType.div, data: '/', column: 12 },
		Token{ token_type: TokenType.num, data: '6.9', column: 14 }]

	assert l.tokenize(input) == expected
}
