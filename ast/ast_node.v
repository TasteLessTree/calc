module ast

pub enum Operator {
	add
	sub
	mul
	div
}

pub struct NumberNode {
pub:
	value f32
}

pub struct BinaryNode {
pub:
	operator Operator
	left     AstNode
	right    AstNode
}

pub type AstNode = NumberNode | BinaryNode

// Evaluate the AST
pub fn evaluate(node &AstNode) !f32 {
	return match node {
		NumberNode {
			node.value
		}
		BinaryNode {
			left := evaluate(node.left)!
			right := evaluate(node.right)!

			match node.operator {
				.add {
					left + right
				}
				.sub {
					left - right
				}
				.mul {
					left * right
				}
				.div {
					if right == 0.0 {
						return error('Cannot divide by zero')
					}

					left / right
				}
			}
		}
	}
}

// Printing the AST
fn print_indent(depth int) {
	for i in 0 .. depth {
		print(' ')
	}
}

pub fn print_ast(node &AstNode, depth int) {
	match node {
		NumberNode {
			print_indent(depth)
			println('NUMBER(${node.value})')
		}
		BinaryNode {
			print_indent(depth)

			match node.operator {
				.add {
					println('ADD(+)')
					print_ast(node.left, depth + 1)
					print_ast(node.right, depth + 1)
				}
				.sub {
					println('SUB(-)')
					print_ast(node.left, depth + 1)
					print_ast(node.right, depth + 1)
				}
				.mul {
					println('MUL(*)')
					print_ast(node.left, depth + 1)
					print_ast(node.right, depth + 1)
				}
				.div {
					println('DIV(/)')
					print_ast(node.left, depth + 1)
					print_ast(node.right, depth + 1)
				}
			}
		}
	}
}
