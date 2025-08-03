class_name FloatingText extends Control

@export var icon_size: int = 64
@export var duration: float = 1
@export var displacement: Vector2

@export var label: RichTextLabel

var tween: Tween

func play(text: String, colour: Color = Color(1, 1, 1, 1),
icon: Texture2D = null) -> void:
	label.text = ""
	if icon:
		label.add_image(
			icon, icon_size, 0, Color(1, 1, 1, 1), INLINE_ALIGNMENT_CENTER)
	label.push_color(colour)
	label.push_bold()
	label.append_text(text)

	tween = create_tween().set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(
		self, "global_position", global_position + displacement, duration)
	tween.parallel().tween_property(
		self, "modulate", Color(1, 1, 1, 0), duration)
	tween.tween_callback(self.queue_free)
