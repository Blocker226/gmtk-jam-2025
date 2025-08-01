class_name PlantTexture extends TextureRect

@export var textures: Array[Texture2D]

func on_growth_change(growth: float, growthTime: float) -> void:
	texture = textures[int(growth / growthTime * len(textures))]
