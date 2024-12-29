# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [PackedInt32Array] return value.
class_name ErrorReturnPackedInt32Array extends ErrorReturn

## Initialize the error return.
func _init(value: PackedInt32Array = PackedInt32Array(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> PackedInt32Array:
	return _value
