class_name FloatingTextSpawner extends Control

@export var scene: PackedScene

func _ready() -> void:
	assert(scene)

func spawn_floating_text(text: String, colour: Color = Color(1, 1, 1, 1),
icon: Texture2D = null, down: bool = false) -> void:
	var floating_text: FloatingText = scene.instantiate()
	add_child(floating_text)
	if down:
		floating_text.displacement *= -1
	floating_text.global_position = global_position
	floating_text.play(text, colour, icon)
