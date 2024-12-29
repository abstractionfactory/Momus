# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Object] return value.
class_name ErrorReturnObject extends ErrorReturn

## Initialize the error return.
func _init(value: Object = null, error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Object:
	return _value
