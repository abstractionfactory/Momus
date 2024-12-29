@tool
@icon("res://addons/momus/icons/momus.svg")
## An error return carries an error or a return value.
class_name ErrorReturn extends RefCounted

var _error: ErrorMessage
var _value: Variant

## Initialize the error return.
func _init(value: Variant = null, error: ErrorMessage = null) -> void:
	_value = value
	_error = error

## Returns the value carried by the error return.
func get_value() -> Variant:
	return _value

## Returns the error carried by the error return.
func get_error() -> ErrorMessage:
	return _error

## Returns true if no error has happened.
func is_ok() -> bool:
	return _error == null

## Returns true if the return carries an error.
func is_error() -> bool:
	return _error != null
