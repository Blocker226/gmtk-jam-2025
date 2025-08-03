class_name UpgradeMenu extends Control

@export var money: IntVariable
@export var upgrade_list: UpgradeList
@export var buy_button: Button
@export var selection: PlantSelection

var current_plant: PlantButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money.changed.connect(_on_money_changed)


func _on_buy_button_pressed() -> void:
	var upgrade: UpgradeData = upgrade_list.get_selected_upgrade()
	var price := upgrade.get_price(
		current_plant.upgrades.get_count(upgrade))
	if money.value < price:
		return
	money.value -= price
	if upgrade.type == UpgradeData.Type.PLANT:
		current_plant.add_upgrade(upgrade_list.get_selected_upgrade())
	elif upgrade.type == UpgradeData.Type.GARDEN:
		for plant: PlantButton in selection.all_plants:
			plant.add_upgrade(upgrade_list.get_selected_upgrade())
	upgrade_list.update_selection(current_plant)
	_on_upgrade_list_item_selected()


func _on_money_changed() -> void:
	if not current_plant: return
	upgrade_list.update_selection(current_plant)
	_on_upgrade_list_item_selected()


func _on_upgrade_list_item_selected() -> void:
	var item: TreeItem = upgrade_list.get_selected()
	if item == null or _get_current_price() > money.value:
		_disable_buy_button()
	else:
		buy_button.disabled = false
		buy_button.text = "Buy %s - %s" % [item.get_text(0), item.get_text(1)]


func _on_upgrade_list_nothing_selected() -> void:
	_disable_buy_button()


func update_selection(plant: PlantButton) -> void:
	current_plant = plant
	upgrade_list.update_selection(plant)
	upgrade_list.deselect_collapse_all()


func _disable_buy_button() -> void:
	buy_button.disabled = true
	buy_button.text = "-"


func _get_current_price() -> int:
	var upgrade: UpgradeData = upgrade_list.get_selected_upgrade()
	if upgrade:
		return upgrade.get_price(
			current_plant.upgrades.get_count(upgrade))
	return 0
