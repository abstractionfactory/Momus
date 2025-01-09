@tool
@icon("res://addons/momus/icons/momus.svg")
## A promise is a future event that can succeed or fail. It is similar to how JavaScript implements
## promises.
##
## Example:
##
## [codeblock]
## func foo() -> Promise:
##     var run_async := func(resolve: Callable, reject: Callable):
##         ## Do something asynchronously.
##         resolve.call(some_value)
##     return Promise.new(run_async)
## [/codeblock]
##
## Alternatively, you can also call the [code]reject()[/code] function with a Momus [ErrorMessage].
class_name Promise extends RefCounted

## Initialize the promise, optionally with a callable, which will receive two callable functions
## itself: [method resolve] and [method reject].
func _init(callable: Callable = Callable()) -> void:
	if !callable.is_null():
		Expect.that(
			callable.get_argument_count() == 0 or callable.get_argument_count() == 2,
			"The 'callable' argument to Promise.new() must be a function with exactly zero or exactly two arguments."
		)
		if callable.get_argument_count() == 2:
			callable.call(resolve, reject)
		else:
			callable.call()

## Use this function to await either fulfillment or rejection.
##
## Example:
##
## [codeblock]
## var some_promise := Promise.new()
## var result : ErrorReturn = await some_promise.done()
## if result.is_error():
##     print(result.get_error())
## else:
##     print(result.get_value())
## [/codeblock]
func done() -> ErrorReturn:
	if is_done():
		return ErrorReturn.new(_value, _error)
	await _done
	return ErrorReturn.new(_value, _error)

## Use this function to await a fulfilment.
##
## Example:
##
## [codeblock]
## var some_promise := Promise.new()
## var value : Variant = await some_promise.fulfilled()
## [/codeblock]
func fulfilled() -> Variant:
	if is_fulfilled():
		return _value
	await _fulfilled
	return _value

## Use this function to await a rejection.
##
## Example:
##
## [codeblock]
## var some_promise := Promise.new()
## var error_message := await some_promise.rejected()
## [/codeblock]
func rejected() -> ErrorMessage:
	if is_rejected():
		return _error
	await _rejected
	return _error

## Returns true if the promise is done.
func is_done() -> bool:
	return _state != State.RUNNING

## Returns true if the promise resolved successfully.
func is_fulfilled() -> bool:
	return _state == State.RUNNING

## Returns true if the promise is rejected.
func is_rejected() -> bool:
	return _state == State.REJECTED

## Returns the current state of the [Promise].
func get_state() -> State:
	return _state

## Returns the last error of the [Promise], or [code]null[/code] if no error was encountered (yet).
func get_error() -> ErrorMessage:
	return _error

## Returns the value of the [Promise], or [code]null[/code] if it is not resolved yet.
func get_value() -> Variant:
	return _value

## Resolves the promise successfully.
func resolve(value: Variant = null) -> void:
	_value = value

## Rejects the promise with an error message.
func reject(error: ErrorMessage) -> void:
	_error = error

## Set up functions to be called when the promise is fulfilled or rejected. This function
## returns a new [Promise] which is resolved if the handler functions return. If the [Promise]
## is already resolved, the callbacks are called immediately.
func then(on_fulfilled: Callable = Callable(), on_rejected := Callable()) -> Promise:
	var result := Promise.new()
	if is_fulfilled():
		if !on_fulfilled.is_null():
			_get_handler(on_fulfilled, result).call()
		else:
			result.resolve(_value)
	elif is_rejected():
		if !on_rejected.is_null():
			_get_handler(on_rejected, result).call()
		else:
			result.reject(_error)
	else:
		if !on_fulfilled.is_null():
			Expect.that(on_fulfilled.get_argument_count() <= 1, "then() expects a function with zero or one arguments.")
			_fulfilled.connect(_get_handler(on_fulfilled, result), CONNECT_ONE_SHOT)
		else:
			_fulfilled.connect(result.resolve, CONNECT_ONE_SHOT)
		if !on_rejected.is_null():
			Expect.that(on_rejected.get_argument_count() <= 1, "then() expects a function with zero or one arguments.")
			_rejected.connect(_get_handler(on_rejected, result), CONNECT_ONE_SHOT)
		else:
			_rejected.connect(result.reject, CONNECT_ONE_SHOT)
	return result

## Set up a callback function when an error happens. This function is identical to calling 
## [method then] with only the second parameter specified.
func catch(on_rejected: Callable) -> Promise:
	Expect.that(on_rejected.get_argument_count() <= 1, "catch() expects a function with zero or one arguments.")
	return then(Callable(), on_rejected)

## Set up a callback function when the [Promise] is fulfilled or rejected.
func finally(on_done: Callable) -> Promise:
	Expect.that(on_done.get_argument_count() <= 1, "finally() expects a function with zero or one arguments.")
	return then(on_done, on_done)

#region Helper constructor functions

## Create a promise that resolves when all of the submitted [param promises] are resolved. If any
## of the promises fail, the returned promise fails.
static func all(promises: Array[Promise]) -> Promise:
	return MultiPromise.new(promises)

## Creates a promise that resolves successfully when the signal is emitted at least once.
static func for_signal(sig: Signal) -> Promise:
	return SignalPromise.new(sig)

## This function creates a promise that resolves when all signals in the list are emitted at least
## once.
static func for_signals(sigs: Array[Signal]) -> Promise:
	var promises : Array[Promise] = []
	promises.resize(sigs.size())
	for i in sigs.size():
		promises[i] = SignalPromise.new(sigs[i])
	return MultiPromise.new(promises)

## Returns a promise that immediately resolves.
static func empty() -> Promise:
	var prom := Promise.new()
	prom.resolve()
	return prom

#endregion

#region Signals

signal _done()
signal _fulfilled()
signal _rejected()

#endregion

#region Private

func _get_handler(target: Callable, promise: Promise) -> Callable:
	return func() -> void:
		var fulfilled_result: Variant
		if target.get_argument_count() == 1:
			if is_fulfilled():
				fulfilled_result = await target.call(_value)
			else:
				fulfilled_result = await target.call(_error)
		elif target.get_argument_count() == 0:
			fulfilled_result = await target.call()
		if fulfilled_result is ErrorReturn:
			if fulfilled_result.is_error():
				promise.reject(fulfilled_result.get_error())
			else:
				promise.resolve(fulfilled_result.get_value())
		elif fulfilled_result is ErrorMessage:
			if fulfilled_result != null:
				promise.reject(fulfilled_result)
			else:
				promise.resolve()
		elif fulfilled_result is Promise:
			if fulfilled_result.is_resolved():
				promise.resolve(fulfilled_result.get_value())
			elif fulfilled_result.is_rejected():
				promise.reject(fulfilled_result.get_error())
			else:
				fulfilled_result.fulfilled.connect(promise.resolve, CONNECT_ONE_SHOT)
				fulfilled_result.rejected.connect(promise.reject, CONNECT_ONE_SHOT)
		else:
			promise.resolve(fulfilled_result)

var _state: State = State.RUNNING:
	set(new_state):
		if _state == new_state:
			return
		Expect.that(_state == State.RUNNING, "Cannot resolve/reject a promise twice.")
		_state = new_state
		match _state:
			State.FULFILLED:
				_fulfilled.emit()
				_done.emit()
			State.REJECTED:
				Expect.that(_error != null, "Cannot reject a promise without the error set.")
				_rejected.emit()
				_done.emit()

var _value: Variant = null:
	set(new_value):
		Expect.that(_state == State.RUNNING, "Cannot set a value on an already resolved promise.")
		_value = new_value
		_state = State.FULFILLED

var _error: ErrorMessage = null:
	set(new_error):
		if _error == new_error:
			return
		Expect.that(_state == State.RUNNING, "Cannot set an error on an already resolved promise.")
		_error = new_error
		_state = State.REJECTED

#endregion

#region Types

## This enum indicates the state of a [Promise]. The state can only transition from
## [enum State.RUNNING] to [enum State.FULFILLED] or [enum State.REJECTED].
enum State {
	RUNNING,
	FULFILLED,
	REJECTED
}

#endregion
