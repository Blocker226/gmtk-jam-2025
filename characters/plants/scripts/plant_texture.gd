class_name PlantTexture extends TextureRect

@export var button: PlantButton

var texture_length: int

func _ready() -> void:
	visible = false
	texture_length = len(button.plant.textures)
	call_deferred("_update_position")


func _on_plant_event_growth_changed(growth: float, growth_time: float) -> void:
	texture = \
	button.plant.textures[roundi(
		growth / growth_time * (texture_length - 3)) + 1]


func _on_plant_event_growth_completed() -> void:
	texture = button.plant.textures[-1]


func _on_plant_event_harvested() -> void:
	texture = button.plant.textures[0]


func _on_plant_event_planted() -> void:
	pass


func _on_plant_event_purchased() -> void:
	visible = true
	texture = button.plant.textures[0]


func _update_position() -> void:
	if button.plant.offset == Vector2.ZERO: return
	var offset: Vector2 = button.plant.offset * (size.y / 512)
	var anchor_offset: Vector2 = Vector2(offset.x / size.x, offset.y / size.y)
	anchor_top += anchor_offset.y
	anchor_bottom += anchor_offset.y
	anchor_left -= anchor_offset.x
	anchor_right -= anchor_offset.x
