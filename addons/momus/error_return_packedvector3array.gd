# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedVector3Array] return value.
class_name ErrorReturnPackedVector3Array extends ErrorReturn

## Initialize the error return.
func _init(value: PackedVector3Array = PackedVector3Array(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedVector3Array:
	return _value
