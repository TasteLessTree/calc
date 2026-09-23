/*
	Defines helper functions and all the sum types for the tests
	This way, only the files ending in `_test.v`
	contain the actual tests functions being run by `v test .`
*/
module tests

import ast
import lexer

type AstNode = ast.AstNode
type NumberNode = ast.NumberNode
type BinaryNode = ast.BinaryNode
type Operator = ast.Operator
type Token = lexer.Token
type TokenType = lexer.TokenType

fn assertion_failed_msg[T](actual T, expected T) string {
	separator_str := '\n------------------------\n'

	// Print the AST that's generated if `T` happens to be `AstNode` at compile time
	// We know the only sum type is `AstNode`
	$if actual is $sumtype {
		print(separator_str)
		println('\tGot:')
		ast.print_ast(actual, 0)
		print(separator_str)

		println('\tExpected:')
		ast.print_ast(expected, 0)
		return separator_str
	}

	actual_str := '${separator_str}\tGot:\n${actual}'
	expected_str := '${separator_str}\tExpected:\n${expected}'
	return '${actual_str} ${separator_str} ${expected_str} ${separator_str}'
}

fn create_number_node(value f64) AstNode {
	return AstNode(NumberNode{ value: value })
}
