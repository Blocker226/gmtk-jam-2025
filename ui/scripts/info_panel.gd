class_name InfoPanel extends PanelContainer

@export var icon: TextureRect
@export var name_label: Label
@export var desc_label: RichTextLabel
@export var sell_price_label: RichTextLabel
@export var progressBar: ProgressBar

@onready var sell_format: String = sell_price_label.text


func update_selection(plant: PlantData) -> void:
	icon.texture = plant.textures[-1]
	name_label.text = plant.name
	desc_label.text = plant.description
	sell_price_label.text = sell_format % plant.sell_price
