extends Marker2D
@export var enemigoSpawnear: PackedScene

var is_spawned: bool = false

func spawn_enemy():
	var new_enemy=enemigoSpawnear.instantiate()
	new_enemy.global_position=global_position
	
	get_parent().add_child(new_enemy)
	
	

func _on_visible_on_screen_notifier_screen_entered() -> void:
	if not is_spawned:
		spawn_enemy()
		queue_free()
		is_spawned=true


func _on_visible_on_screen_notifier_screen_exited() -> void:
	if enemigoSpawnear:
		is_spawned=false
