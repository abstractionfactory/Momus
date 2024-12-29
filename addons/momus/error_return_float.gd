# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [float] return value.
class_name ErrorReturnFloat extends ErrorReturn

## Initialize the error return.
func _init(value: float = float(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> float:
	return _value
