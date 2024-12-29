@tool
## This script regenerates all error return types in this project.
class_name GenerateErrorReturns extends EditorScript

var _types := {
	"AABB": "AABB",
	"Array": "Array",
	"Basis": "Basis",
	"bool": "Bool",
	"Callable": "Callable",
	"Color": "Color",
	"Dictionary": "Dictionary",
	"float": "Float",
	"int": "Int",
	"NodePath": "NodePath",
	"Object": "Object",
	"PackedByteArray": "PackedByteArray",
	"PackedColorArray": "PackedColorArray",
	"PackedFloat32Array": "PackedFloat32Array",
	"PackedFloat64Array": "PackedFloat64Array",
	"PackedInt32Array": "PackedInt32Array",
	"PackedInt64Array": "PackedInt64Array",
	"PackedStringArray": "PackedStringArray",
	"PackedVector2Array": "PackedVector2Array",
	"PackedVector3Array": "PackedVector3Array",
	"PackedVector4Array": "PackedVector4Array",
	"Plane": "Plane",
	"Projection": "Projection",
	"Quaternion": "Quaternion",
	"Rect2": "Rect2",
	"Rect2i": "Rect2i",
	"RID": "RID",
	"Signal": "Signal",
	"String": "String",
	"StringName": "StringName",
	"Transform2D": "Transform2D",
	"Transform3D": "Transform3D",
	"Vector2": "Vector2",
	"Vector2i": "Vector2i",
	"Vector3": "Vector3",
	"Vector3i": "Vector3i",
	"Vector4": "Vector4",
	"Vector4i": "Vector4i",
}

func _run() -> void:
	var generator := MomusErrorReturnGenerator.new()
	for type in _types.keys():
		var cls : String = _types[type]
		var file := "res://addons/momus/error_return_%s.gd"%[type.to_lower()]
		print("Writing file %s..."%[file])
		var default : String = type + "()"
		if type == "Object":
			default = "null"
		Expect.no_error(generator.generate_file(
			file,
			type,
			cls,
			default
		))
