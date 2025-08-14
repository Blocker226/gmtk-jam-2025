class_name SaveSystem extends Node

signal game_saved
signal game_loaded

@export var autosave_setting: BoolVariable
@export var resources: Array[SavedResource]

const default_path: String = "user://savegame.save"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not OS.is_userfs_persistent():
		print(
			"File system may not be persistent, there might be issues saving.")
	if not FileAccess.file_exists(default_path):
		return
	else:
		load_game(default_path)


func save_game(path: String = default_path) -> bool:
	var save_file := FileAccess.open(path, FileAccess.WRITE)
	if not save_file:
		printerr("Could not open file at ", path)
		print(FileAccess.get_open_error())
		return false
	var save_data: Dictionary = {}
	for resource in resources:
		save_data.merge(resource.save(), true)
	# TODO: save plant data
	var json: String = JSON.stringify(save_data)
	save_file.store_string(json)
	print("Game saved to ", save_file.get_path_absolute())
	save_file.close()
	game_saved.emit()
	return true


func load_game(path: String = default_path) -> bool:
	var save_file := FileAccess.open(path, FileAccess.READ)
	if not save_file:
		printerr("Could not open file at ", path)
		print(FileAccess.get_open_error())
		return false
	var file_length: int = save_file.get_length()
	var json_string: String = save_file.get_as_text()

	# Creates the helper class to interact with JSON.
	var json := JSON.new()

	# Check if there is any error while parsing the JSON string,
	# skip in case of failure.
	var parse_result: Error = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ",
		json.get_error_message(),
		" in ", json_string, " at line ", json.get_error_line())
		return false
	print(json.data)
	if json.data is not Dictionary:
		print("JSON save data format is not valid!")
		return false
	var json_dict: Dictionary = json.data
	for resource in resources:
		if not json_dict.has(resource.resource_name): continue
		resource.load(json_dict[resource.resource_name])
		prints("Loaded data for", resource.resource_name)
	print("Game loaded from ", save_file.get_path_absolute())
	save_file.close()
	game_loaded.emit()
	return true


func delete_save(path: String = default_path) -> bool:
	if FileAccess.file_exists(path):
		if DirAccess.remove_absolute(path) == OK:
			prints("Save file deleted:", path)
			return true
		else:
			return false
	else:
		print("No save file found to delete.")
		return false


func _on_auto_save_timer_timeout() -> void:
	if autosave_setting.value:
		save_game()
