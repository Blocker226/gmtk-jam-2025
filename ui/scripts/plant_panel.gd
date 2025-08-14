class_name PlantPanel extends Panel

signal save_pressed
signal load_pressed
signal delete_pressed

@export var selection: PlantSelection
@export var news_label: NewsLabel
@export var info_panel: InfoPanel
@export var upgrade_menu: UpgradeMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info_panel.visible = false
	upgrade_menu.visible = false


func _on_plant_selection_selection_changed() -> void:
	if not news_label.tutorial_completed:
		news_label.advance_tutorial()
	info_panel.update_selection(selection.selected_plant)
	info_panel.visible = true
	upgrade_menu.update_selection(selection.selected_plant)
	upgrade_menu.visible = true


func _on_save_menu_save_pressed() -> void:
	save_pressed.emit()


func _on_save_menu_load_pressed() -> void:
	load_pressed.emit()


func _on_save_menu_delete_pressed() -> void:
	delete_pressed.emit()
