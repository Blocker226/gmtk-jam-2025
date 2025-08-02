class_name DirtTexture extends TextureRect

@export var grass_textures: Array[Texture2D] = []
@export var dirt_textures: Array[Texture2D] = []


func _ready() -> void:
	texture = grass_textures[randi_range(0, len(grass_textures) - 1)]


func _on_plant_event_purchased() -> void:
	texture = dirt_textures[0]


func _on_plant_upgrades_upgrade_installed(upgrade: UpgradeData) -> void:
	if "dirt" in upgrade.added_keywords:
		texture = dirt_textures[1]
