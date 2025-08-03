class_name EndScreen extends SplashScreen

@export var money: IntVariable
@export var threshold: int


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if money.value >= threshold:
		visible = true
