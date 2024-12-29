# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Vector3i] return value.
class_name ErrorReturnVector3i extends ErrorReturn

## Initialize the error return.
func _init(value: Vector3i = Vector3i(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Vector3i:
	return _value
