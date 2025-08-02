class_name PlantProgressBar extends ProgressBar


func _on_plant_event_growth_changed(growth: float, growth_time: float) -> void:
	value = growth / growth_time * max_value


func _on_plant_event_harvested() -> void:
	value = 0
