class_name IntVariable extends Resource

@export var value: int:
	get:
		return value
	set(v):
		value = v
		emit_changed()
