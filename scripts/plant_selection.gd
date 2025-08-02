class_name PlantSelection extends Node

signal selection_changed

var all_plants: Array[PlantButton]

var selected_plant: PlantButton:
	get:
		return selected_plant
	set(value):
		selected_plant = value
		selection_changed.emit()


func _ready() -> void:
	for node in get_tree().get_nodes_in_group("Plants"):
		var button := node as PlantButton
		button.plant_pressed.connect(_on_plant_pressed)
		all_plants.append(button)


func select(new_selected_plant: PlantButton) -> void:
	selected_plant = new_selected_plant


func _on_plant_pressed(plant: PlantButton) -> void:
	select(plant)
