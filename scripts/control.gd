extends Control

@onready var play: TextureButton = $Container/VBoxContainer/TextureButton
@onready var exit: TextureButton = $Container/VBoxContainer/TextureButton2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.pressed.connect(_play_presionado)
	exit.pressed.connect(_exit_presionado)

func _play_presionado()->void:
	get_tree().change_scene_to_file("res://scenes/mapa2.tscn")
	
func _exit_presionado()->void:
	get_tree().quit()
