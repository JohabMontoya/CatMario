extends Node2D
@onready var sprite = $Sprite2D
@onready var detector_abajo = $Area2D/CollisionShape2D

var position_original: Vector2
var hitted: bool = false

func _ready() -> void:
	position_original = position
	sprite.play("bloque")

func romper_bloque():
	hitted = true
	detector_abajo.set_deferred("disabled", true)
	var tween = create_tween()
	tween.tween_property(self, "position:y", position_original.y - 10, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", position_original.y, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not hitted:
		romper_bloque()
