extends Node


var positions := { }

func save_position(scene_path : String, pos: Vector2) -> void:
	positions[scene_path] = pos

func has_position(scene_path: String) -> bool:
	return positions.has(scene_path)

func get_position(scene_path: String) -> Vector2:
	return positions[scene_path]
