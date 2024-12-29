# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Transform3D] return value.
class_name ErrorReturnTransform3D extends ErrorReturn

## Initialize the error return.
func _init(value: Transform3D = Transform3D(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Transform3D:
	return _value
