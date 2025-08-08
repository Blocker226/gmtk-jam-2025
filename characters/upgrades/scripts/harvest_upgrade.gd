class_name HarvestUpgrade extends UpgradeData

@export var harvest_delay: float = 3

func process_upgrade(plant: PlantButton, delta: float) -> void:
	super(plant, delta)

	var progress_bar := \
	plant.upgrades.get_node("Harvester 5000/ProgressBar") as ProgressBar

	if plant.state == PlantButton.State.READY:
		plant.upgrades.upgrade_keywords["harvest_time"] += delta
		var elapsed_time: float = \
		plant.upgrades.upgrade_keywords["harvest_time"]

		progress_bar.visible = true
		progress_bar.value = \
		elapsed_time / harvest_delay * progress_bar.max_value

		if elapsed_time < harvest_delay: return
		plant.harvest()
		plant.upgrades.upgrade_keywords["harvest_time"] = 0
		progress_bar.value = 0
		progress_bar.visible = false
	else:
		plant.upgrades.upgrade_keywords["harvest_time"] = 0
		progress_bar.visible = false


func on_upgrade_installed(plant_upgrades: PlantUpgrades) -> void:
	super(plant_upgrades)

	var progress_bar := \
	plant_upgrades.get_node("Harvester 5000/ProgressBar") as ProgressBar
	progress_bar.visible = false
