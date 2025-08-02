class_name PlantButton extends Button

signal plant_pressed(plant: PlantButton)

enum State {
	EMPTY,
	GROWING,
	READY
}

@export var enabled: bool = false
@export var plant: PlantData
@export var money: IntVariable
@export var price_label: Label
@export var upgrades: PlantUpgrades

var state: State = State.EMPTY
var growth: float = 0
var plant_events: Array[PlantEvent]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in find_children("PlantEvent", "", true):
		plant_events.append(child as PlantEvent)
	assert(price_label)
	if enabled:
		price_label.visible = false
	price_label.text = price_label.text % plant.initial_cost


func _physics_process(delta: float) -> void:
	if not enabled: return
	for upgrade in upgrades.current_upgrades:
		upgrade.process_upgrade(self, delta)
	update_growth(delta)


func add_upgrade(upgrade: UpgradeData) -> void:
	upgrades.install_upgrade(upgrade)


func get_water_effectiveness() -> float:
	return plant.water_effectiveness


func _on_pressed() -> void:
	if not enabled:
		if _purchase():
			plant_pressed.emit(self)
		return
	plant_pressed.emit(self)
	if state == State.EMPTY:
		_plant()
		return
	if growth >= plant.grow_time:
		_harvest()
		return
	update_growth(plant.water_effectiveness)


func update_growth(progress: float) -> bool:
	if state != State.GROWING or growth >= plant.grow_time: return false
	var total_progress: float = progress

	for upgrade: UpgradeData in upgrades.current_upgrades:
		total_progress += upgrade.get_added_growth(progress)

	growth = minf(growth + total_progress, plant.grow_time)
	for event in plant_events:
		event.growth_change(growth, plant.grow_time)
		if growth >= plant.grow_time:
			event.growth_complete()
	return true


func _harvest() -> void:
	growth = 0
	for event in plant_events:
		event.harvest()
	state = State.EMPTY
	money.value += plant.sell_price

	if "replant" in upgrades.upgrade_keywords:
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
