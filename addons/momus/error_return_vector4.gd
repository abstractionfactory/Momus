# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Vector4] return value.
class_name ErrorReturnVector4 extends ErrorReturn

## Initialize the error return.
func _init(value: Vector4 = Vector4(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Vector4:
	return _value
