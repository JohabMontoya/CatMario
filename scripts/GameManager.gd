extends Node

signal health_changed(current_health: int, max_health: int)
signal player_died

var max_health: int = 3
var current_health: int = 3

func take_damage(amount: int = 1) -> void:
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)

	health_changed.emit(current_health, max_health)

	if current_health <= 0:
		player_died.emit()

func heal(amount: int = 1) -> void:
	current_health += amount
	current_health = clamp(current_health, 0, max_health)

	health_changed.emit(current_health, max_health)

func reset() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)
