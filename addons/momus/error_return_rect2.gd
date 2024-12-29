# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Rect2] return value.
class_name ErrorReturnRect2 extends ErrorReturn

## Initialize the error return.
func _init(value: Rect2 = Rect2(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Rect2:
	return _value
