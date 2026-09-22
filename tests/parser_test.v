module tests

import lexer
import parser

fn test_parse_sigle_digit_number() {
	input := '5'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := create_number_node(5.0)

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_float_number() {
	input := '6.9'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := create_number_node(6.9)

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_simple_addition() {
	input := '27 + 42'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := AstNode(BinaryNode{
		operator: Operator.add
		left:     create_number_node(27.0)
		right:    create_number_node(42.0)
	})

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_addition_and_division() {
	input := '1 + 2 / 3'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := AstNode(BinaryNode{
		operator: Operator.add
		left:     create_number_node(1.0)
		right:    AstNode(BinaryNode{
			operator: Operator.div
			left:     create_number_node(2.0)
			right:    create_number_node(3.0)
		})
	})

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_multiplication_between_parenthesis_with_substraction() {
	input := '1 - (2 * 3)'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := AstNode(BinaryNode{
		operator: Operator.sub
		left:     create_number_node(1.0)
		right:    AstNode(BinaryNode{
			operator: Operator.mul
			left:     create_number_node(2.0)
			right:    create_number_node(3.0)
		})
	})

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_correct_order_with_parenthesis() {
	input := '(1 - 2) * 3'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := AstNode(BinaryNode{
		operator: Operator.mul
		left:     AstNode(BinaryNode{
			operator: Operator.sub
			left:     create_number_node(1.0)
			right:    create_number_node(2.0)
		})
		right:    create_number_node(3.0)
	})

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_with_multiple_parenthesis() {
	input := '(4 * 3) / (1 + 2) - 5'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := AstNode(BinaryNode{
		operator: Operator.sub
		left:     AstNode(BinaryNode{
			operator: Operator.div
			left:     AstNode(BinaryNode{
				operator: Operator.mul
				left:     create_number_node(4.0)
				right:    create_number_node(3.0)
			})
			right:    AstNode(BinaryNode{
				operator: Operator.add
				left:     create_number_node(1.0)
				right:    create_number_node(2.0)
			})
		})
		right:    create_number_node(5.0)
	})

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}

fn test_parse_nested_parenthesis() {
	input := '((9 / 7) + 5 * 8) - (6 + 4)'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := AstNode(BinaryNode{
		operator: Operator.sub
		left:     AstNode(BinaryNode{
			operator: Operator.add
			left:     AstNode(BinaryNode{
				operator: Operator.div
				left:     create_number_node(9.0)
				right:    create_number_node(7.0)
			})
			right:    AstNode(BinaryNode{
				operator: Operator.mul
				left:     create_number_node(5.0)
				right:    create_number_node(8.0)
			})
		})
		right:    AstNode(BinaryNode{
			operator: Operator.add
			left:     create_number_node(6.0)
			right:    create_number_node(4.0)
		})
	})

	actual := p.parse()!
	assert actual == expected, assertion_failed_msg(actual, expected)
}
