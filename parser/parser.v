module parser

import ast
import lexer

type Token = lexer.Token

type TokenType = lexer.TokenType

type NumberNode = ast.NumberNode

type BinaryNode = ast.BinaryNode

type Operator = ast.Operator

type AstNode = ast.AstNode

pub struct Parser {
	tokens []Token
mut:
	position int
}

pub fn Parser.new(t []Token) &Parser {
	return &Parser{ tokens: t, position: 0 }
}

// Build the AST
pub fn (mut p Parser) parse() !AstNode {
	node := p.parse_expression()!

	p.expect(TokenType.token_eof)!

	return node
}

// Parse factor
fn (mut p Parser) parse_factor() !AstNode {
	token := p.peek()

	match token.token_type {
		.num {
			p.consume()

			return AstNode(NumberNode{ value: token.data.f64() })
		}
		.left_parent {
			p.consume()

			expression := p.parse_expression()!

			p.expect(.right_parent)!

			return expression
		}
		else {
			return error('Expected a number or an open parenthesis.\nGot: "${token.data}" (${token.token_type}), column: ${token.column}')
		}
	}
}

// Parse an expression with order of preference ('*' and '/' then '+' and -'')
fn (mut p Parser) parse_term() !AstNode {
	mut left := p.parse_factor()!

	for {
		operator := match p.peek().token_type {
			.mult {
				Operator.mul
			}
			.div {
				Operator.div
			}
			else {
				break
			}
		}

		p.consume()

		right := p.parse_factor()!

		left = AstNode(BinaryNode{
			operator: operator
			left:     left
			right:    right
		})
	}

	return left
}

// Parse and expression (addition and subtraction)
fn (mut p Parser) parse_expression() !AstNode {
	mut left := p.parse_term()!

	for {
		operator := match p.peek().token_type {
			.plus {
				Operator.add
			}
			.sub {
				Operator.sub
			}
			else {
				break
			}
		}

		p.consume()

		right := p.parse_term()!

		left = AstNode(BinaryNode{
			operator: operator
			left:     left
			right:    right
		})
	}

	return left
}

// Peek the current token type
fn (p &Parser) peek() Token {
	return p.tokens[p.position]
}

// Consume and advance the position, returning the token we've just consumed
fn (mut p Parser) consume() Token {
	token := p.peek()
	p.position++

	return token
}

// Expect a token and return it
fn (mut p Parser) expect(expected_token_type TokenType) !Token {
	token := p.peek()

	if token.token_type != expected_token_type {
		return error('Expected: "${expected_token_type}".\nGot: "${token.data}" (${token.token_type}), column: ${token.column}')
	}

	// Consume the current token and return it
	p.consume()
	return token
}
