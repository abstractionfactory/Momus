@tool
## This generator produces [GDScript] code for a specific error return type.
##
## You can use this to generate your own custom error return types with
## an [EditorScript]:
## [codeblock]
## @tool
## extends EditorScript
##
## func _run() -> void:
##     var generator := MomusErrorReturnGenerator.new()
##     Expect.no_error(generator.generate_file(
##         # Path to the file to write:
##         "res://path/to/your/error_return_custom.gd",
##         # Native type, e.g. int, or your custom class name:
##         "Custom",
##         # Generated class name suffix:
##         "Custom",
##         # Default value:
##         "null"
##     )
## [/codeblock]
class_name MomusErrorReturnGenerator extends RefCounted

## Generate GDScript code and return it as a string.
##
## You can use this to generate a custom error return type, for example to use with [GDScript]:
## [codeblock]
## extends Node
##
## func _ready() -> void:
##     var generator := MomusErrorReturnGenerator.new()
##     var gdscript := GDScript.new()
##     gdscript.source_code = generator.generate_string(
##         # Native type, e.g. int, or your custom class name:
##         "Custom",
##         # Generated class name suffix:
##         "Custom",
##         # Default value:
##         "null"
##     )
##     Expect.ok(gdscript.reload())
## [/codeblock]
func generate_string(
	type: String,
	cls: String,
	default_value: String,
	icon: String = "res://addons/momus/icons/momus.svg"
) -> String:
	var result := "# SPDX-License-Identifier: MIT\n"
	result += "# Generated code, do not modify!\n"
	result += "\n"
	result += "@tool\n"
	if icon != "":
		result += "@icon(\"%s\")\n"%[icon.c_escape()]
	result += "## An error return carries an error or a(n) [%s] return value.\n"%[type]
	result += "class_name ErrorReturn%s extends ErrorReturn\n"%[cls]
	result += "\n"
	result += "## Initialize the error return.\n"
	result += "func _init(value: %s = %s, error: ErrorMessage = null) -> void:\n"%[type, default_value]
	result += "\tsuper._init(value, error)\n"
	result += "\n"
	result += "## Returns the value stored in the error return.\n"
	result += "func get_value() -> %s:\n"%[type]
	result += "\treturn _value\n"
	return result

## Generate GDScript code into a file.
##
## You can use this to generate your own custom error return types with
## an [EditorScript]:
## [codeblock]
## @tool
## extends EditorScript
##
## func _run() -> void:
##     var generator := MomusErrorReturnGenerator.new()
##     Expect.no_error(generator.generate_file(
##         # Path to the file to write:
##         "res://path/to/your/error_return_custom.gd",
##         # Native type, e.g. int, or your custom class name:
##         "Custom",
##         # Generated class name suffix:
##         "Custom",
##         # Default value:
##         "null"
##     )
## [/codeblock]
func generate_file(
	file: String,
	type: String,
	cls: String,
	default_value: String,
	icon: String = "res://addons/momus/icons/momus.svg"
) -> ErrorMessage:
	var gen := generate_string(type, cls, default_value, icon)
	
	var fh := FileAccess.open(file, FileAccess.WRITE)
	var err: Error
	if fh == null:
		err = FileAccess.get_open_error()
		return ErrorMessage.new(err, "Could not open %s (%s)"%[file, error_string(err)])
	fh.store_string(gen)
	err = fh.get_error()
	if err != OK:
		return ErrorMessage.new(err, "Could not write to %s (%s)"%[file, error_string(err)])
	fh.close()
	err = fh.get_error()
	if err != OK:
		return ErrorMessage.new(err, "Could not write to %s (%s)"%[file, error_string(err)])
	return null
