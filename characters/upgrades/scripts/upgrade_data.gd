class_name UpgradeData extends Resource

enum Type {
	PLANT,
	GARDEN
}

@export var name: String
@export_multiline var description: String
@export var icon: Texture2D
@export var type: Type
@export var is_repeatable: bool = false
@export var base_price: int = 10
@export var requirements: Dictionary[String, Variant] = {}
@export var added_keywords: Dictionary[String, Variant] = {}


func process_upgrade(_plant: PlantButton, _delta: float) -> void:
	pass


func get_price(currently_owned: int) -> int:
	return int(base_price * pow(1.15, currently_owned))


func get_added_growth(_progress: float) -> float:
	return 0


func is_valid(plant_upgrades: PlantUpgrades) -> bool:
	if self in plant_upgrades.current_upgrades and not is_repeatable:
		return false

	var result: bool = true
	for key in requirements:
		if not key in plant_upgrades.upgrade_keywords:
			return false
		elif requirements[key] == null:
			continue
		elif requirements[key] != plant_upgrades.upgrade_keywords[key]:
			return false
	return result


func on_upgrade_installed(plant_upgrades: PlantUpgrades) -> void:
	print("Installing upgrade %s" % name)
	for key in added_keywords:
		if key.contains("_add") and plant_upgrades.upgrade_keywords.has(key):
			plant_upgrades.upgrade_keywords[key] += added_keywords[key]
		else:
			plant_upgrades.upgrade_keywords[key] = added_keywords[key]

## This is called after any upgrade is installed, for a recalculation.
func refresh(_plant_upgrades: PlantUpgrades) -> void:
	pass
