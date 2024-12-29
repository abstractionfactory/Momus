# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [int] return value.
class_name ErrorReturnInt extends ErrorReturn

## Initialize the error return.
func _init(value: int = int(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> int:
	return _value
