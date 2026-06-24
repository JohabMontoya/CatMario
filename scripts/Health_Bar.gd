extends CanvasLayer

@onready var container: HBoxContainer = $HBoxContainer

var sprite: Texture2D = preload("res://Sprites/catMario1.png")

func _ready() -> void:
	GameManager.health_changed.connect(update_hearts)
	update_hearts(GameManager.current_health, GameManager.max_health)

func update_hearts(current_health: int, max_health: int) -> void:
	for child in container.get_children():
		child.queue_free()

	for i in range(max_health):
		var heart := TextureRect.new()

		heart.texture = sprite
		heart.custom_minimum_size = Vector2(32, 32)
		heart.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

		if i >= current_health:
			heart.modulate.a = 0.25

		container.add_child(heart)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("TECLA"):
		GameManager.take_damage()
