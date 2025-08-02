class_name SprinklerUpgrade extends UpgradeData

@export var delay: float = 5

var _animation_player: AnimationPlayer
var _elapsed_time: float

func process_upgrade(plant: PlantButton, delta: float) -> void:
	_elapsed_time += delta
	if _elapsed_time < delay: return

	_elapsed_time = 0
	if plant.update_growth(plant.get_water_effectiveness()):
		_animation_player.play("run")


func on_upgrade_installed(plant_upgrades: PlantUpgrades) -> void:
	super(plant_upgrades)
	var node := plant_upgrades.get_node("Sprinkler/AnimationPlayer")
	if not node is AnimationPlayer: return

	_animation_player = node as AnimationPlayer


func refresh(plant_upgrades: PlantUpgrades) -> void:
	if "sprinkler_speed" in plant_upgrades.upgrade_keywords:
		delay *= plant_upgrades.upgrade_keywords["sprinkler_speed"]
		print("Sprinkler delay is now %f" % delay)
