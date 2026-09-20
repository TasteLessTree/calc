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
	invalid
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
			.invalid {
				tokens << l.handle_invalid_tokens(input)
			}
			.eof {
				break
			}
		}
	}

	tokens << Token{ token_type: TokenType.token_eof, column: l.column }

	return tokens
}

// Returns the current byte WITHOUT consuming it
fn (l &Lexer) peek(source string) Char {
	if l.position >= source.len {
		return Char.eof
	}
	return check_character(source[l.position])
}

// Returns the NEXT byte WITHOUT consuming it
fn (l &Lexer) peek_next(source string) Char {
	if l.position + 1 >= source.len {
		return Char.eof
	}
	return check_character(source[l.position + 1])
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
fn is_symbol(b u8) bool {
	return b == `+` || b == `-` || b == `/` || b == `*` || b == `(` || b == `)`
}

// Check whether a given byte is a digit
fn is_number(b u8) bool {
	return b >= `0` && b <= `9`
}

// Check wheter a given byte is a whitespace
fn is_whitespace(b u8) bool {
	return b == ` ` || b == `\t` || b == `\n` || b == `\r` || b == `\v` || b == `\f`
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

// Handle invalid tokens (such as letters)
// The tokenization continues (will be handle by the parser)
fn (mut l Lexer) handle_invalid_tokens(source string) Token {
	start := l.position
	start_column := l.column

	for l.peek(source) == Char.invalid {
		l.consume(source)
	}

	word := source.substr(start, l.position)

	return Token{ token_type: TokenType.invalid, data: word, column: start_column }
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
fn check_character(b u8) Char {
	return match true {
		b.is_letter() {
			Char.invalid
		}
		is_whitespace(b) {
			Char.whitespace
		}
		is_number(b) {
			Char.number
		}
		is_symbol(b) {
			Char.symbol
		}
		else {
			Char.eof
		}
	}
}
