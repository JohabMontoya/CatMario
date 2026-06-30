extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#GameManager.player_died.connect(on_player_died)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	var current_scene_path := get_tree().current_scene.scene_file_path
	
	PlayerState.save_position(current_scene_path, Vector2(body.position.x+50,body.position.y))
	get_tree().change_scene_to_file("res://scenes/mapa2.tscn")
