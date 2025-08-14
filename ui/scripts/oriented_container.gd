class_name OrientedContainer extends BoxContainer

@onready var viewport: Viewport = get_viewport()

@onready var current_viewport_size: Array[Vector2] = [Vector2.ZERO]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_viewport_size[0] = viewport.get_visible_rect().size
	vertical = current_viewport_size[0].x < current_viewport_size[0].y
