class_name WindowFocus extends Node

signal window_focused
signal window_unfocused

func _ready() -> void:
	get_window().focus_entered.connect(_on_window_focus_entered)
	get_window().focus_exited.connect(_on_window_focus_exited)


func _on_window_focus_entered() -> void:
	print("Window/Tab focused.")
	window_focused.emit()


func _on_window_focus_exited() -> void:
	print("Window/Tab unfocused.")
	window_unfocused.emit()
