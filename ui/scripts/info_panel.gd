class_name InfoPanel extends PanelContainer

@export var icon: TextureRect
@export var name_label: Label
@export var desc_label: RichTextLabel
@export var sell_price_label: RichTextLabel
@export var stat_harvested_label: Label
@export var progressBar: ProgressBar

@onready var sell_format: String = sell_price_label.text
@onready var stat_harvested_format: String = stat_harvested_label.text


func update_selection(plant_button: PlantButton) -> void:
	var plant: PlantData = plant_button.plant
	icon.texture = plant.icon
	name_label.text = plant.name
	desc_label.text = plant.description
	sell_price_label.text = sell_format % plant.sell_price

	stat_harvested_label.text = \
	stat_harvested_format % plant_button.stats_harvested
