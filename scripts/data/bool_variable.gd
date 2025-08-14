class_name BoolVariable extends SavedResource

@export var value: bool:
	get:
		return value
	set(v):
		value = v
		emit_changed()

func save() -> Dictionary:
	return {resource_name: value}

func load(data: Variant) -> void:
	if data is not bool:
		prints(data, "is not a valid value for", resource_name)
		return
	value = data
