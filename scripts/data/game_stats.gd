class_name GameStats extends Resource

@export var stats: Dictionary[String, Variant] = {}

func get_stat(key: String, default_value: Variant) -> Variant:
	if not stats.has(key):
		stats[key] = default_value
	return stats[key]

func add_stat(key: String, value: Variant) -> void:
	if not stats.has(key):
		stats[key] = 0 if value is int else 0.0
	stats[key] += value
