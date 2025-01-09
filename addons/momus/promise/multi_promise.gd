@tool
## A multi-promise is a promise waiting for multiple other promises to resolve.
class_name MultiPromise extends Promise

var _remaining := 0
var _errors : Array[ErrorMessage] = []

func _init(promises: Array[Promise]) -> void:
	_remaining = promises.size()
	for promise in promises:
		promise.done.connect(_on_done, CONNECT_ONE_SHOT)

func _on_done(error: ErrorMessage) -> void:
	if error != null:
		_errors.append(error)
	_remaining -= 1
	if _remaining == 0:
		if _errors.size() == 0:
			resolve()
		else:
			# TODO multi-errors
			reject(ErrorMessage.wrap(_errors[0]))
