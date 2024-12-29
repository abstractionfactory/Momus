# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Vector3] return value.
class_name ErrorReturnVector3 extends ErrorReturn

## Initialize the error return.
func _init(value: Vector3 = Vector3(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Vector3:
	return _value