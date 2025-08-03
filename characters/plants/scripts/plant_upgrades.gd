class_name PlantUpgrades extends Node

signal upgrade_installed(upgrade: UpgradeData)

@export var events: PlantEvent

var upgrade_keywords: Dictionary[String, Variant] = {}

var current_upgrades: Dictionary[UpgradeData, int] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func install_upgrade(upgrade: UpgradeData) -> void:
	upgrade.on_upgrade_installed(self)
	if current_upgrades.has(upgrade):
		current_upgrades[upgrade] += 1
	else:
		current_upgrades[upgrade] = 1
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
	for key in current_upgrades:
		print("%s: %s x %d" % [key, key.name, current_upgrades[key]])
	upgrade_installed.emit(upgrade)

func get_count(upgrade: UpgradeData) -> int:
	return current_upgrades.get(upgrade, 0)
