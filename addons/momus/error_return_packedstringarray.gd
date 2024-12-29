# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedStringArray] return value.
class_name ErrorReturnPackedStringArray extends ErrorReturn

## Initialize the error return.
func _init(value: PackedStringArray = PackedStringArray(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedStringArray:
	return _value
