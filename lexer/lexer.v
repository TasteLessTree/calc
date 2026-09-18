module lexer

pub struct Lexer {
mut:
	position int
	column   int = 1
}

pub fn Lexer.new() Lexer {
	return Lexer{ position: 0, column: 1 }
}

enum Char {
	whitespace
	number
	symbol
	unknown
	eof
}

// Given an input, returns a list(array) of tokens
pub fn (mut l Lexer) tokenize(input string) []Token {
	mut tokens := []Token{cap: 100}

	for l.peek(input) != Char.eof {
		match l.peek(input) {
			.whitespace {
				l.skip_whitespace(input)
			}
			.number {
				tokens << l.read_number(input)
			}
			.symbol {
				tokens << l.read_symbol(input)
			}
			.unknown {
				continue
			}
			.eof {
				break
			}
		}
	}

	return tokens
}

// Returns the current byte WITHOUT consuming it
fn (l Lexer) peek(source string) Char {
	if l.position >= source.len {
		return Char.eof
	}
	return check_character(source[l.position])
}

// Returns the NEXT byte WITHOUT consuming it
fn (l Lexer) peek_next(source string) Char {
	if l.position + 1 >= source.len {
		return Char.eof
	} else {
		return check_character(source[l.position + 1])
	}
}

// Consumes a character
fn (mut l Lexer) consume(source string) {
	if l.position < source.len {
		l.position++
		l.column++
	}
}

// Consumes whitespaces
fn (mut l Lexer) skip_whitespace(source string) {
	for l.peek(source) == Char.whitespace {
		l.consume(source)
	}
}

// Reads and stores a number
fn (mut l Lexer) read_number(source string) Token {
	start := l.position
	start_column := l.column
	mut has_decimal := false

	for l.position < source.len {
		current := source[l.position]

		if is_number(current) {
			l.consume(source)
			continue
		}

		if current == `.` && !has_decimal {
			has_decimal = true
			l.consume(source)
			continue
		}

		break
	}

	word := source.substr(start, l.position)

	return Token{ token_type: check_for_symbols(word), data: word, column: start_column }
}

// Check whether a given byte is a symbol (eg. `+`)
fn is_symbol(byte u8) bool {
	return byte == `+` || byte == `-` || byte == `/` || byte == `*` || byte == `(` || byte == `)`
}

// Check whether a given byte is a digit
fn is_number(byte u8) bool {
	return byte >= `0` && byte <= `9`
}

// Reads and stores a symbol (eg. `+`)
fn (mut l Lexer) read_symbol(source string) Token {
	start := l.position
	start_column := l.column

	for l.peek(source) == Char.symbol {
		l.consume(source)
	}
	word := source.substr(start, l.position)

	return Token{ token_type: check_for_symbols(word), data: word, column: start_column }
}

// Returns the corresponding token type
fn check_for_symbols(word string) TokenType {
	return match word {
		'+' {
			TokenType.plus
		}
		'-' {
			TokenType.sub
		}
		'/' {
			TokenType.div
		}
		'*' {
			TokenType.mult
		}
		'(' {
			TokenType.left_parent
		}
		')' {
			TokenType.right_parent
		}
		else {
			TokenType.num
		}
	}
}

// Returns the corresponding character
fn check_character(byte u8) Char {
	return match true {
		byte.is_space() {
			Char.whitespace
		}
		byte.is_digit() {
			Char.number
		}
		is_symbol(byte) {
			Char.symbol
		}
		byte.is_letter() {
			Char.unknown
		}
		else {
			Char.eof
		}
	}
}
