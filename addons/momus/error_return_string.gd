# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [String] return value.
class_name ErrorReturnString extends ErrorReturn

## Initialize the error return.
func _init(value: String = String(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> String:
	return _value
