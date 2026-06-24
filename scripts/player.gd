extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0

@onready var animation_player = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation_player.play("caminando")
		animation_player.scale.x = direction
		#animation_player.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_player.play("quieto")
	
	if not is_on_floor():
		animation_player.play("salto")
	elif direction:
		animation_player.play("caminando")
	else:
		animation_player.play("quieto")
	
	move_and_slide()
