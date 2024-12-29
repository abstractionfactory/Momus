# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Vector2] return value.
class_name ErrorReturnVector2 extends ErrorReturn

## Initialize the error return.
func _init(value: Vector2 = Vector2(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Vector2:
	return _value
