extends Node2D
@onready var area = $Area2D

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("logica_idle"):
		body.set_physics_process(false)
		body.visible = false
		await get_tree().create_timer(1.0).timeout
		print("ganaste")
		get_tree().change_scene_to_file("res://scenes/control.tscn")
