# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedVector2Array] return value.
class_name ErrorReturnPackedVector2Array extends ErrorReturn

## Initialize the error return.
func _init(value: PackedVector2Array = PackedVector2Array(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedVector2Array:
	return _value
