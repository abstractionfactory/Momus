@tool
## This class is a promise that resolves when a signal is emitted.
class_name SignalPromise extends Promise

func _init(sig: Signal) -> void:
	sig.connect(resolve, CONNECT_ONE_SHOT)
