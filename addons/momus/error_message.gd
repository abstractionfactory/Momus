@tool
@icon("res://addons/momus/icons/momus.svg")
## A carrier of an error code and an error message. Can also carry original errors.
class_name ErrorMessage extends RefCounted

## Error code.
var code: Error
## Customized error message.
var message: String
## Original error that caused this error.
var cause: ErrorMessage

## Initialize the error. The message is optional and will be compited from the code if not
## presented.
func _init(new_code: Error, new_message: String = "", new_cause: ErrorMessage = null) -> void:
	assert(new_code >= OK, "Please provide a positive error code.")
	assert(new_code != OK, "Please use null instead of an error with the OK code.")
	code = new_code
	message = new_message
	cause = new_cause

## Traverses any cause errors and returns true if any of them have the specified code.
func has_code(err_code: Error) -> bool:
	if code == err_code:
		return true
	if cause == null:
		return false
	return cause.has_code(err_code)

## Create a wrapped error of the original error.
static func wrap(original: ErrorMessage, new_code: Error = -1, new_message: String = "") -> ErrorMessage:
	if original == null:
		return null
	if new_code == OK:
		new_code = original.code
	return ErrorMessage.new(
		new_code, new_message, original
	)

## Transforms the [enum Error] into its textual representation.
static func code_to_text(code: Error) -> StringName:
	if _code_to_text.has(code):
		return _code_to_text[code]
	return "ERR_UNKNOWN"

func _to_string() -> String:
	var result := code_to_text(code)
	if message != "":
		result += ": %s"%[message]
	else:
		result += ": %s"%[error_string(code)]
	if cause != null:
		result += " (%s)"%[cause.to_string()]
	return result

static var _code_to_text := {
	OK: "OK",
	FAILED: "FAILED",
	ERR_UNAVAILABLE: "ERR_UNAVAILABLE",
	ERR_UNCONFIGURED: "ERR_UNCONFIGURED",
	ERR_UNAUTHORIZED: "ERR_UNAUTHORIZED",
	ERR_PARAMETER_RANGE_ERROR: "ERR_PARAMETER_RANGE_ERROR",
	ERR_OUT_OF_MEMORY: "ERR_OUT_OF_MEMORY",
	ERR_FILE_NOT_FOUND: "ERR_FILE_NOT_FOUND",
	ERR_FILE_BAD_DRIVE: "ERR_FILE_BAD_DRIVE",
	ERR_FILE_BAD_PATH: "ERR_FILE_BAD_PATH",
	ERR_FILE_NO_PERMISSION: "ERR_FILE_NO_PERMISSION",
	ERR_FILE_ALREADY_IN_USE: "ERR_FILE_ALREADY_IN_USE",
	ERR_FILE_CANT_OPEN: "ERR_FILE_CANT_OPEN",
	ERR_FILE_CANT_WRITE: "ERR_FILE_CANT_WRITE",
	ERR_FILE_CANT_READ: "ERR_FILE_CANT_READ",
	ERR_FILE_UNRECOGNIZED: "ERR_FILE_UNRECOGNIZED",
	ERR_FILE_CORRUPT: "ERR_FILE_CORRUPT",
	ERR_FILE_MISSING_DEPENDENCIES: "ERR_FILE_MISSING_DEPENDENCIES",
	ERR_FILE_EOF: "ERR_FILE_EOF",
	ERR_CANT_OPEN: "ERR_CANT_OPEN",
	ERR_CANT_CREATE: "ERR_CANT_CREATE",
	ERR_QUERY_FAILED: "ERR_QUERY_FAILED",
	ERR_ALREADY_IN_USE: "ERR_ALREADY_IN_USE",
	ERR_LOCKED: "ERR_LOCKED",
	ERR_TIMEOUT: "ERR_TIMEOUT",
	ERR_CANT_CONNECT: "ERR_CANT_CONNECT",
	ERR_CANT_RESOLVE: "ERR_CANT_RESOLVE",
	ERR_CONNECTION_ERROR: "ERR_CONNECTION_ERROR",
	ERR_CANT_ACQUIRE_RESOURCE: "ERR_CANT_ACQUIRE_RESOURCE",
	ERR_CANT_FORK: "ERR_CANT_FORK",
	ERR_INVALID_DATA: "ERR_INVALID_DATA",
	ERR_INVALID_PARAMETER: "ERR_INVALID_PARAMETER",
	ERR_ALREADY_EXISTS: "ERR_ALREADY_EXISTS",
	ERR_DOES_NOT_EXIST: "ERR_DOES_NOT_EXIST",
	ERR_DATABASE_CANT_READ: "ERR_DATABASE_CANT_READ",
	ERR_DATABASE_CANT_WRITE: "ERR_DATABASE_CANT_WRITE",
	ERR_COMPILATION_FAILED: "ERR_COMPILATION_FAILED",
	ERR_METHOD_NOT_FOUND: "ERR_METHOD_NOT_FOUND",
	ERR_LINK_FAILED: "ERR_LINK_FAILED",
	ERR_SCRIPT_FAILED: "ERR_SCRIPT_FAILED",
	ERR_CYCLIC_LINK: "ERR_CYCLIC_LINK",
	ERR_INVALID_DECLARATION: "ERR_INVALID_DECLARATION",
	ERR_DUPLICATE_SYMBOL: "ERR_DUPLICATE_SYMBOL",
	ERR_PARSE_ERROR: "ERR_PARSE_ERROR",
	ERR_BUSY: "ERR_BUSY",
	ERR_SKIP: "ERR_SKIP",
	ERR_HELP: "ERR_HELP",
	ERR_BUG: "ERR_BUG",
	ERR_PRINTER_ON_FIRE: "ERR_PRINTER_ON_FIRE"
}
