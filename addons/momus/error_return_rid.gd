# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [RID] return value.
class_name ErrorReturnRID extends ErrorReturn

## Initialize the error return.
func _init(value: RID = RID(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> RID:
	return _value
