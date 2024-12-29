# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedInt64Array] return value.
class_name ErrorReturnPackedInt64Array extends ErrorReturn

## Initialize the error return.
func _init(value: PackedInt64Array = PackedInt64Array(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedInt64Array:
	return _value
