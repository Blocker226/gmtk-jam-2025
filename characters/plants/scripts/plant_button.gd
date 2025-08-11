class_name PlantButton extends Node

signal plant_pressed(plant: PlantButton)
signal stats_changed()

enum State {
	EMPTY,
	GROWING,
	READY,
	HARVESTING
}

@export var enabled: bool = false
@export var plant: PlantData
@export var money: IntVariable
@export var price_label: Label
@export var upgrades: PlantUpgrades
@export var floating_text: FloatingTextSpawner
@export var harvest_timer: Timer
@export_group("Keywords")
@export var growth_multiply_keyword: String = "growth_multiply"
@export var water_add_keyword: String = "water_add"
@export var water_multiply_keyword: String = "water_multiply"
@export var replant_keyword: String = "replant"
@export var harvest_keyword: String = "harvest"
@export_group("Effects")
@export var water_particles: WaterParticles

var stats_harvested: int = 0:
	get:
		return stats_harvested
	set(value):
		stats_harvested = value
		stats_changed.emit()

var state: State = State.EMPTY:
	get:
		return state
	set(value):
		for event in plant_events:
			event.state_change(state, value)
		state = value
var growth: float = 0
var plant_events: Array[PlantEvent]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in find_children("PlantEvent", "", true):
		plant_events.append(child as PlantEvent)
	assert(price_label)
	if enabled:
		price_label.visible = false

	price_label.text = price_label.text % format_number(plant.initial_cost)


func _physics_process(delta: float) -> void:
	if not enabled: return
	for upgrade in upgrades.current_upgrades:
		upgrade.process_upgrade(self, delta)
	update_growth(delta)


func add_upgrade(upgrade: UpgradeData) -> void:
	upgrades.install_upgrade(upgrade)


func get_water_effectiveness() -> float:
	return plant.water_effectiveness * upgrades.upgrade_keywords.get(
		water_multiply_keyword, 1) + upgrades.upgrade_keywords.get(
		water_add_keyword, 0)


func _on_pressed() -> void:
	if not enabled:
		if _purchase():
			plant_pressed.emit(self)
		return
	plant_pressed.emit(self)
	if state == State.EMPTY:
		_plant()
		return
	if growth >= plant.grow_time and state != State.HARVESTING:
		harvest(true)
		return
	elif state != State.HARVESTING:
		update_growth(get_water_effectiveness())
		water_particles.play_at_mouse()


func update_growth(progress: float) -> bool:
	if state != State.GROWING or growth >= plant.grow_time: return false
	var total_progress: float = progress

	for upgrade: UpgradeData in upgrades.current_upgrades:
		total_progress += upgrade.get_added_growth(progress)

	total_progress *= upgrades.upgrade_keywords.get(growth_multiply_keyword, 1)

	growth = minf(growth + total_progress, plant.grow_time)
	for event in plant_events:
		event.growth_change(growth, plant.grow_time)
		if growth >= plant.grow_time:
			state = State.READY
			event.growth_complete()
	return true


func harvest(manual: bool = false) -> void:
	growth = 0
	state = State.HARVESTING
	if not manual:
		harvest_timer.start(plant.harvest_time)
	else:
		harvest_timer.start(plant.harvest_time / 2)


func _on_harvest_timer_timeout() -> void:
	assert(state == State.HARVESTING)
	for event in plant_events:
		event.harvest()
	state = State.EMPTY
	money.value += plant.sell_price
	floating_text.spawn_floating_text(
		"+$%d" % plant.sell_price, Color.GREEN, plant.icon)

	stats_harvested += 1

	if replant_keyword in upgrades.upgrade_keywords:
		_plant()


func _plant() -> void:
	for event in plant_events:
		event.plant()
	state = State.GROWING


func _purchase() -> bool:
	if money.value < plant.initial_cost:
		return false
	money.value -= plant.initial_cost
	for event in plant_events:
		event.purchase()
	enabled = true
	price_label.visible = false
	return true


func format_number(number: int) -> String:
	var human_number: String = ""
	var i: int = 0
	var s: String = str(number)
	if len(s) > 3:
		for c in s.reverse():
			if i == 3:
				human_number = ',' + human_number
				i = 0
			i += 1
			human_number = c + human_number
	else:
		human_number = s

	return human_number
