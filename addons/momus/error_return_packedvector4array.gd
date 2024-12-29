# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedVector4Array] return value.
class_name ErrorReturnPackedVector4Array extends ErrorReturn

## Initialize the error return.
func _init(value: PackedVector4Array = PackedVector4Array(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedVector4Array:
	return _value
