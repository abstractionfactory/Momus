# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [NodePath] return value.
class_name ErrorReturnNodePath extends ErrorReturn

## Initialize the error return.
func _init(value: NodePath = NodePath(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> NodePath:
	return _value
