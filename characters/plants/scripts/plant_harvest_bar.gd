class_name PlantHarvestBar extends ProgressBar

@export var harvest_timer: Timer

var tween: Tween

func _on_plant_event_state_changed(old_state: PlantButton.State, new_state: PlantButton.State) -> void:
	if (old_state == PlantButton.State.READY and
	new_state == PlantButton.State.HARVESTING):
		visible = true
		value = 100
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(self, "value", 0, harvest_timer.wait_time)


func _on_plant_event_harvested() -> void:
	value = 0
	visible = false
	if tween:
		tween.kill()
