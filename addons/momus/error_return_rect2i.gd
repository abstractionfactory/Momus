# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Rect2i] return value.
class_name ErrorReturnRect2i extends ErrorReturn

## Initialize the error return.
func _init(value: Rect2i = Rect2i(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Rect2i:
	return _value
