class_name PlantUpgrades extends Node

signal upgrade_installed(upgrade: UpgradeData)

@export var events: PlantEvent

var upgrade_keywords: Dictionary[String, Variant] = {}

var current_upgrades: Array[UpgradeData] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func install_upgrade(upgrade: UpgradeData) -> void:
	upgrade.on_upgrade_installed(self)
	current_upgrades.append(upgrade)
	for key in upgrade_keywords:
		print("%s: %s" % [key, upgrade_keywords[key]])
	for existing_upgrade in current_upgrades:
		existing_upgrade.refresh(self)
	# Make the upgrade visible if the name matches
	for child: Node in get_children():
		if child.name != upgrade.name: continue
		if child is Control:
			var control := child as Control
			control.visible = true
	upgrade_installed.emit(upgrade)

func count_existing_upgrades(upgrade_name: String) -> int:
	var count: int = 0
	for upgrade in current_upgrades:
		if upgrade.name == upgrade_name:
			count += 1
	return count
