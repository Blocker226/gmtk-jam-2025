class_name PlantData extends Resource

@export var icon: Texture2D
@export var name: String
@export_multiline var description: String

@export_custom(PROPERTY_HINT_NONE, "suffix:s") var grow_time: float
@export var water_effectiveness: float = 1
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var harvest_time: float = 3.0
@export var initial_cost: int
@export var sell_price: int

@export var offset: Vector2
@export var textures: Array[Texture2D]
