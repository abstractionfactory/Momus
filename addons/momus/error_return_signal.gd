# SPDX-License-Identifier: MIT
# Generated code, do not modify!

@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a(n) [Signal] return value.
class_name ErrorReturnSignal extends ErrorReturn

## Initialize the error return.
func _init(value: Signal = Signal(), error: ErrorMessage = null) -> void:
	super._init(value, error)

## Returns the value stored in the error return.
func get_value() -> Signal:
	return _value
