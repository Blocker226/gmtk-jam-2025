class_name VariableLabel extends RichTextLabel

@export var variable: IntVariable
@export var floating_text: FloatingTextSpawner
@export var progress_bar: ProgressBar

var format: String
var old_number: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(variable)
	format = text

	variable.changed.connect(_on_variable_changed)
	_update_number()


func _on_variable_changed() -> void:
	if old_number > variable.value:
		floating_text.spawn_floating_text(
			"-$%d" % (old_number - variable.value), Color.RED, null, true)
	elif old_number < variable.value:
		floating_text.spawn_floating_text(
			"+$%d" % (variable.value - old_number), Color.GREEN, null)

	_update_number()


func _update_number() -> void:
	old_number = variable.value
	var human_number: String = ""
	var i: int = 0
	var s: String = str(variable.value)
	if len(s) > 3:
		for c in s.reverse():
			if i == 3:
				human_number = ',' + human_number
				i = 0
			i += 1
			human_number = c + human_number
	else:
		human_number = s

	text = format % human_number

	progress_bar.value = variable.value
