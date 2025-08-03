class_name HarvestUpgrade extends UpgradeData

@export var harvest_delay: float = 3

var _elapsed_time: float
var _progress_bar: ProgressBar

func process_upgrade(plant: PlantButton, delta: float) -> void:
	super(plant, delta)
	if plant.state == PlantButton.State.READY:
		_elapsed_time += delta

		_progress_bar.visible = true
		_progress_bar.value = \
		_elapsed_time / harvest_delay * _progress_bar.max_value

		if _elapsed_time < harvest_delay: return
		plant.harvest()
		_elapsed_time = 0
		_progress_bar.value = 0
		_progress_bar.visible = false
	else:
		_elapsed_time = 0
		_progress_bar.visible = false


func on_upgrade_installed(plant_upgrades: PlantUpgrades) -> void:
	super(plant_upgrades)

	_progress_bar = \
	plant_upgrades.get_node("Harvester 5000/ProgressBar") as ProgressBar
	_progress_bar.visible = false
