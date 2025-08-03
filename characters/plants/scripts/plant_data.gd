class_name PlantData extends Resource

@export var icon: Texture2D
@export var name: String
@export_multiline var description: String

@export var grow_time: float
@export var water_effectiveness: float = 1
@export var initial_cost: int
@export var sell_price: int

@export var textures: Array[Texture2D]
@export var offset: Vector2
