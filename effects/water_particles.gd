class_name WaterParticles extends CPUParticles2D

@export var sound: AudioStreamPlayer2D

func play_at_mouse() -> void:
	global_position = get_global_mouse_position()
	emitting = true
	if not sound.playing:
		sound.play()
