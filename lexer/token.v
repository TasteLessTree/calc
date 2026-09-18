module lexer

pub enum TokenType {
	invalid
	num
	plus
	sub
	div
	mult
	right_parent
	left_parent
}

pub struct Token {
pub:
	token_type TokenType
	data       string
	column     int
}

pub fn (t Token) str() string {
	return 'Token {TokenType: ${get_token_type(t.token_type)}, data: `${t.data}`, column: ${t.column}}'
}

fn get_token_type(t TokenType) string {
	return match t {
		.invalid {
			'invalid token'
		}
		.num {
			'number'
		}
		.plus {
			'addition'
		}
		.sub {
			'subtraction'
		}
		.div {
			'division'
		}
		.mult {
			'multiplication'
		}
		.right_parent {
			'right parenthesis'
		}
		.left_parent {
			'left parenthesis'
		}
	}
}
