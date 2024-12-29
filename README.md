<h1><img src="addons/momus/icons/momus.svg" alt="" align="right"> Momus - The missing error handling library for Godot</h1>

This library provides error handling data types, such as an error with an error message or return
types with additional errors, for Godot.

## `ErrorMessage`

Momus defines the [`ErrorMessage`](addons/momus/error_message.gd) as the basic type to carry an
error message. It carries the Godot-specific error code, an error message, and the original error
wrapped with it. You can create an error like this:

```gdscript
return ErrorMessage.new(
	ERR_BUG,
	"You have encountered a bug!"
)
```

You can also wrap an error you encountered from a lower-level function. This way you can always
extract the original error if needed.

```gdscript
func do_something() -> ErrorMessage:
	var err : ErrorMessage = do_something_dangerous()
	if err != null:
		return Error.wrap(
			err,
			ERR_BUG,
			"You have encountered a bug. See the following error message for details."
		)
```

## `ErrorReturn`

A feature that's sorely missing from GDScript is the ability to return a value and an error
at the same time. [`ErrorReturn`](addons/momus/error_return.gd) fills this need. Consider a
function returning a string:

```gdscript
func produce_string() -> ErrorReturnString:
	return ErrorReturnString.new("Hello world!")
```

Alternatively, this function could also return an error:

```gdscript
func produce_string() -> ErrorReturnString:
	return ErrorReturnString.from_error(Error.new(ERR_BUG, "Whoops, something went wrong!"))
```

On the calling side you can check this error and extract the value:

```gdscript
var ret := produce_string()
if ret.is_error():
	printerr(ret.get_error())
else:
	print(ret.get_value())
```

> [!TIP]
> You can easily generate your own custom `ErrorReturn` types with the
> [`MomusErrorReturnGenerator`](addons/momus/generator/momus_error_return_generator.gd). Check
> the class documentation for examples.

## `Expect`

In GDScript, the `assert` function provides a convenient way to check if an input meets validation
requirements. However, any lines containing an `assert` are stripped when exporting the project 
for a production build. The [`Expect`](addons/momus/expect.gd) class fills this need by providing
tools to validate a value and crash the application if the validation fails.

For example:

```gdscript
@export
var packed_scene: PackedScene

func _ready() -> void:
	Expect.that(packed_scene != null, "Please provide a packed scene.")
	add_child(packed_scene.instantiate())
```

You can also use it for error handling where errors typically don't occur:

```gdscript
Expect.ok(my_signal.connect(my_handler))
```
