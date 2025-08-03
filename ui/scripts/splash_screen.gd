class_name SplashScreen extends Button

@export var fade_duration: float = 1

var _tween: Tween
var _pressed: bool = false


func _on_pressed() -> void:
	if _pressed: return
	_pressed = true
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN)\
	.tween_property(self, "modulate", Color(1, 1, 1, 0), fade_duration)
	_tween.tween_callback(queue_free).set_delay(fade_duration)
