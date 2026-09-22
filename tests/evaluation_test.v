module tests

import ast
import lexer
import parser

fn test_evaluation_single_digit_number() {
	input := '5'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 5.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_addition() {
	input := '47 + 22'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 69.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_addition_with_float_values() {
	input := '4.7 + 5.3'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 10.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_subtraction() {
	input := '45 - 25'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 20.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_subtraction_with_negative_result() {
	input := '7 - 10'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := -3.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_multiplication() {
	input := '7 * 2'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 14.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_division() {
	input := '4 / 2'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 2.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_division_non_integer_result() {
	input := '1 / 2'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 0.5

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_correct_order_of_operations() {
	input := '1 * 2 + 3'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 5.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_correct_order_of_operations_with_parenthesis() {
	input := '(1 / 2) - 3'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := -2.5

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_with_parenthesis() {
	input := '(8 - 9) * 7'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := -7.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_with_multiple_parenthesis() {
	input := '(4 * 3) / (1 + 2) - 5'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := -1.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_with_nested_parenthesis() {
	input := '((9 + 7) * 0.5) - 1'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 7.0

	assert ast.evaluate(p.parse()!)! == expected
}

fn test_evaluation_with_multiple_nested_parenthesis() {
	input := '((9 + 7) * (0.5 - 1) / 8) + 3'

	mut l := lexer.Lexer.new()
	mut p := parser.Parser.new(l.tokenize(input))

	expected := 2.0

	assert ast.evaluate(p.parse()!)! == expected
}
