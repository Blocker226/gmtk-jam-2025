class_name VariableLabel extends RichTextLabel

@export var variable: IntVariable

var format: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(variable)
	format = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = format % variable.value
