@tool
@icon("res://addons/momus/icons/momus.svg")
## This class makes it easy to handle unexpected hard errors at runtime.
class_name Expect extends Object

## Expect a certian expression to be true and crash with an error message if it is not.
static func that(expression: bool, message: String = "") -> void:
	assert(expression, message)
	if expression:
		return
	if Engine.is_editor_hint():
		# Don't crash the editor.
		return
	if !OS.is_debug_build():
		printerr(message)
		OS.alert(message)
	var tree := Engine.get_main_loop()
	tree.auto_accept_quit(true)
	tree.quit(1)

## Expects a non-null value.
static func not_null(value: Variant, message: String = "") -> void:
	Expect.that(value != null, message)

## Expects an [ErrorMessage] value of [code]null[/code]
static func no_error(err: ErrorMessage) -> void:
	if err == null:
		return
	Expect.that(err == null, err.to_string())

## Expects an [enum Error] value of [code]OK[/code].
static func ok(err: Error) -> void:
	Expect.that(err == OK, "Expected OK, got %s instead."%[error_string(err)])
