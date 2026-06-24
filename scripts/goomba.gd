extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
var SPEED = -100.0
var muerto: bool = false
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	animated_sprite.play("moverse")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = SPEED
	
	move_and_slide()
	
	if is_on_wall():
		SPEED = - SPEED
		animated_sprite.flip_h = SPEED > 0
	

func morir() -> void:
	if muerto:
		return
	muerto = true
	animated_sprite.play("morir")
	$CollisionShape2D.set_deferred("disabled", true)
	await animated_sprite.animation_finished
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		GameManager.take_damage()
