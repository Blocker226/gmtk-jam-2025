class_name PlantPanel extends Panel

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
