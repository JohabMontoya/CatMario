extends StaticBody2D
@onready var area = $Area2D
var tocada: bool = false

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not tocada and body.has_method("logica_idle"):
		tocada = true
		await bajar_bandera(body)

func bajar_bandera(mario: Node2D):
	mario.set_physics_process(false)
	
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y + 700, 1.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	
	mario.set_physics_process(true)
	while not mario.is_on_floor():
		await get_tree().process_frame
	
	mario.auto_caminar = true
