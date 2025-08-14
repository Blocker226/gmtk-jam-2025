class_name WindowFocus extends Node

signal window_focused
signal window_unfocused

var last_focus_time: int = 0

var web_focus_callback: JavaScriptObject

func _ready() -> void:
	last_focus_time = Time.get_ticks_msec()

	# Visibility checking for web platform only
	if OS.has_feature("web"):
		web_focus_callback = JavaScriptBridge.create_callback(
			_on_web_focus_change)
		@warning_ignore("unsafe_method_access")
		JavaScriptBridge.get_interface("document").addEventListener(
			"visibilitychange", web_focus_callback)
	#else:
		#get_window().focus_entered.connect(_on_window_focus_entered)
		#get_window().focus_exited.connect(_on_window_focus_exited)


func _on_web_focus_change(event: Array) -> void:
	print_verbose(event)
	var document := JavaScriptBridge.get_interface("document")
	@warning_ignore("unsafe_property_access")
	if document.hidden:
		_on_window_focus_exited()
	else:
		_on_window_focus_entered()


func _on_window_focus_entered() -> void:
	print("Window/Tab focused (%dms)." % get_time_difference_msec())
	window_focused.emit()


func _on_window_focus_exited() -> void:
	print("Window/Tab unfocused.")
	last_focus_time = Time.get_ticks_msec()
	window_unfocused.emit()


func get_time_difference_msec() -> int:
	return Time.get_ticks_msec() - last_focus_time
