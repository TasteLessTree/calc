module tests

import lexer

fn test_tokenize_single_digit_number() {
	input := '5'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.num, data: input, column: 1 },
		Token{ token_type: TokenType.token_eof, column: 2 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_double_digit_number() {
	input := '13'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.num, data: input, column: 1 },
		Token{ token_type: TokenType.token_eof, column: 3 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_triple_digit_number() {
	input := '420'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.num, data: input, column: 1 },
		Token{ token_type: TokenType.token_eof, column: 4 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_float_number() {
	input := '6.9'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.num, data: input, column: 1 },
		Token{ token_type: TokenType.token_eof, column: 4 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_single_symbol() {
	input := '/'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.div, data: input, column: 1 },
		Token{ token_type: TokenType.token_eof, column: 2 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_symbols_and_numbers() {
	input := '(13 + 420) / 6.9'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.left_parent, data: '(', column: 1 },
		Token{ token_type: TokenType.num, data: '13', column: 2 },
		Token{ token_type: TokenType.plus, data: '+', column: 5 },
		Token{ token_type: TokenType.num, data: '420', column: 7 },
		Token{ token_type: TokenType.right_parent, data: ')', column: 10 },
		Token{ token_type: TokenType.div, data: '/', column: 12 },
		Token{ token_type: TokenType.num, data: '6.9', column: 14 },
		Token{ token_type: TokenType.token_eof, column: 17 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_invalid_input() {
	input := 'v'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.invalid, data: input, column: 1 },
		Token{ token_type: TokenType.token_eof, column: 2 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_valid_input_with_unexpected_characters() {
	input := '21 + c'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.num, data: '21', column: 1 },
		Token{ token_type: TokenType.plus, data: '+', column: 4 },
		Token{ token_type: TokenType.invalid, data: 'c', column: 6 },
		Token{ token_type: TokenType.token_eof, column: 7 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_tokenize_nested_parenthesis() {
	input := '((9 - 3) + 4)'

	mut l := lexer.Lexer.new()

	expected := [Token{ token_type: TokenType.left_parent, data: '(', column: 1 },
		Token{ token_type: TokenType.left_parent, data: '(', column: 2 },
		Token{ token_type: TokenType.num, data: '9', column: 3 },
		Token{ token_type: TokenType.sub, data: '-', column: 5 },
		Token{ token_type: TokenType.num, data: '3', column: 7 },
		Token{ token_type: TokenType.right_parent, data: ')', column: 8 },
		Token{ token_type: TokenType.plus, data: '+', column: 10 },
		Token{ token_type: TokenType.num, data: '4', column: 12 },
		Token{ token_type: TokenType.right_parent, data: ')', column: 13 },
		Token{ token_type: TokenType.token_eof, column: 14 }]

	actual := l.tokenize(input)
	assert actual == expected, assertion_failed_msg(actual, expected)
}
