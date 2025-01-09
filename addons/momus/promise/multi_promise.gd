@tool
@icon("res://addons/momus/icons/momus.svg")
## A multi-promise is a promise waiting for multiple other promises to resolve.
class_name MultiPromise extends Promise

var _remaining := 0
var _errors : Array[ErrorMessage] = []

func _init(promises: Array[Promise]) -> void:
	_remaining = promises.size()
	for promise in promises:
		var prom := promise
		var handler := func() -> void:
			if prom.is_rejected():
				_errors.append(prom.get_error())
			_remaining -= 1
			if _remaining == 0:
				if _errors.size() == 0:
					resolve()
				else:
					# TODO multi-errors
					reject(ErrorMessage.wrap(_errors[0]))
		promise._done.connect(handler, CONNECT_ONE_SHOT)
	
