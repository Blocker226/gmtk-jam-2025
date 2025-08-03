class_name SprinklerUpgrade extends UpgradeData

@export var delay: float = 5
@export var speed_upgrade: UpgradeData

var _elapsed_time: float
var _initial_delay: float

var _animation_player: AnimationPlayer

func process_upgrade(plant: PlantButton, delta: float) -> void:
	super(plant, delta)
	var current_delay: float = plant.upgrades.upgrade_keywords["sprinkler"]
	_elapsed_time += delta
	if _elapsed_time < current_delay: return

	_elapsed_time = 0
	if plant.update_growth(plant.get_water_effectiveness()):
		if current_delay < 0.5 and _animation_player.current_animation != "fast":
			_animation_player.play("fast")
		elif current_delay >= 0.5:
			_animation_player.play("run")


func on_upgrade_installed(plant_upgrades: PlantUpgrades) -> void:
	super(plant_upgrades)

	_initial_delay = delay

	var node := plant_upgrades.get_node("Sprinkler/AnimationPlayer")
	if not node is AnimationPlayer: return

	_animation_player = node as AnimationPlayer


func refresh(plant_upgrades: PlantUpgrades) -> void:
	if "sprinkler_speed" in plant_upgrades.upgrade_keywords:
		plant_upgrades.upgrade_keywords["sprinkler"] = _initial_delay * pow(
			plant_upgrades.upgrade_keywords["sprinkler_speed"],
			plant_upgrades.get_count(speed_upgrade))
		print("Sprinkler delay is now %f" % delay)
