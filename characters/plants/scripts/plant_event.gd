class_name PlantEvent extends Node

signal growth_changed(growth: float, growth_time: float)
signal growth_completed
signal harvested
signal planted
signal purchased
signal state_changed(old_state: PlantButton.State, new_state: PlantButton.State)

func growth_change(growth: float, growth_time: float) -> void:
	growth_changed.emit(growth, growth_time)

func growth_complete() -> void:
	growth_completed.emit()

func harvest() -> void:
	harvested.emit()

func plant() -> void:
	planted.emit()

func purchase() -> void:
	purchased.emit()

func state_change(
	old_state: PlantButton.State, new_state: PlantButton.State) -> void:
	state_changed.emit(old_state, new_state)
