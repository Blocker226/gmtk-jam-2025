class_name UpgradeList extends Tree

var all_upgrades: Array[UpgradeData]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_column_expand_ratio(0, 7)
	set_column_expand_ratio(1, 3)

	for file_name in DirAccess.get_files_at("res://characters/upgrades/data"):
		if (file_name.get_extension() == "import"):
			file_name = file_name.replace('.tres', '')

		var upgrade: UpgradeData = ResourceLoader.load(
			"res://characters/upgrades/data/" + file_name,"UpgradeData") \
			as UpgradeData

		assert(upgrade)

		all_upgrades.append(upgrade)
		all_upgrades.sort_custom(func(a: UpgradeData, b: UpgradeData) -> bool:
			return a.base_price < b.base_price)

		print("Loaded upgrade %s" % file_name)

	var root: TreeItem = create_item()
	root.set_selectable(0, false)

	for upgrade: UpgradeData in all_upgrades:
		var new_item: TreeItem = create_item(root)
		new_item.set_text(0, upgrade.name)
		new_item.set_icon(0, upgrade.icon)
		new_item.set_icon_max_width(0, 64)
		new_item.set_text(1, "$%d" % upgrade.get_price(0))
		new_item.set_metadata(0, upgrade)
		var child_item: TreeItem = create_item(new_item)
		child_item.set_text(0, upgrade.description)
		child_item.set_autowrap_mode(0, TextServer.AUTOWRAP_WORD_SMART)
		child_item.set_selectable(0, false)
		new_item.collapsed = true


func get_selected_upgrade() -> UpgradeData:
	assert(get_selected())
	var metadata: Variant = get_selected().get_metadata(0)
	if metadata is UpgradeData:
		var data: UpgradeData = metadata
		return data
	return null


func update_selection(plant: PlantButton) -> void:
	var all_items: Array[TreeItem] = get_root().get_children()
	for item in all_items:
		var metadata: Variant = item.get_metadata(0)
		if not metadata is UpgradeData:
			continue
		var data: UpgradeData = metadata
		var valid: bool = data.is_valid(plant.upgrades)
		item.visible = valid
		item.set_text(1, "$%d" % data.get_price(
			plant.upgrades.count_existing_upgrades(data.name)))


func _on_item_mouse_selected(
	_mouse_position: Vector2, _mouse_button_index: int) -> void:
	var item: TreeItem = get_selected()
	if not item: return

	item.collapsed = false


func _on_item_selected() -> void:
	var item: TreeItem = get_selected()
	if not item or get_selected_column() != 0: return

	var all_items: Array[TreeItem] = get_root().get_children()
	for other in all_items:
		if other == item: continue
		other.collapsed = true

	item.collapsed = false


func _on_nothing_selected() -> void:
	deselect_all()
	var all_items: Array[TreeItem] = get_root().get_children()
	for item in all_items:
		item.collapsed = true
