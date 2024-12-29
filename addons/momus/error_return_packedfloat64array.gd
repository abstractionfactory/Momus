# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedFloat64Array] return value.
class_name ErrorReturnPackedFloat64Array extends ErrorReturn

## Initialize the error return.
func _init(value: PackedFloat64Array = PackedFloat64Array(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedFloat64Array:
	return _value
