extends CharacterBody2D
enum Estados { IDLE, WALKING, JUMPING, AGACHADO, CORRER, MUERTO}
var estado_actual: Estados = Estados.IDLE
const SPEED = 400.0
const RUN_SPEED = 1200.0
const JUMP_VELOCITY = -600.0 
@onready var animation_player = $AnimatedSprite2D
@onready var hitbox = $Hitbox


var auto_caminar: bool = false
var muerto: bool = false

func _ready() -> void:
	$Hitbox.add_to_group("player_hitbox")
	GameManager.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	if muerto:
		return
	muerto = true
	cambiar_estado(Estados.MUERTO)
	velocity.y = -400.0 
	$CollisionShape2D.set_deferred("disabled", true) 
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/control.tscn")
	GameManager.reset()
	

func _physics_process(delta: float) -> void:
	if muerto:
		velocity += get_gravity() * delta
		move_and_slide()
		return
	if auto_caminar:
		velocity.x = 200.0
		animation_player.play("caminando")
		move_and_slide()
		if not is_on_floor():
			velocity += get_gravity() * delta
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
		if estado_actual != Estados.JUMPING:
			cambiar_estado(Estados.JUMPING)
	match estado_actual:
		Estados.IDLE:
			logica_idle()
		Estados.WALKING:
			logica_walking()
		Estados.JUMPING:
			logica_jumping()
		Estados.AGACHADO:
			logica_agachado()
		Estados.CORRER:
			logica_correr()
	_revisar_pisado()

	move_and_slide()
func cambiar_estado(nuevo_estado: Estados) -> void:
	estado_actual = nuevo_estado
	match estado_actual:
		Estados.MUERTO:
			animation_player.play("muerto")
		Estados.IDLE:
			animation_player.play("quieto")
		Estados.WALKING:
			animation_player.play("caminando")
		Estados.JUMPING:
			animation_player.play("salto")
		Estados.AGACHADO:
			animation_player.play("new_animation")
		Estados.CORRER:
			animation_player.play("corriendo")
func logica_idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_pressed("ui_down"):
		cambiar_estado(Estados.AGACHADO)
	elif Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
		cambiar_estado(Estados.JUMPING)
	elif Input.get_axis("ui_left", "ui_right") != 0:
		if Input.is_action_pressed("correr"):
			cambiar_estado(Estados.CORRER)
		else:
			cambiar_estado(Estados.WALKING)
func logica_walking() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation_player.flip_h = direction < 0
	if Input.is_action_pressed("ui_down"):
		cambiar_estado(Estados.AGACHADO)
	elif Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
		cambiar_estado(Estados.JUMPING)
	elif Input.is_action_pressed("correr") and direction != 0:
		cambiar_estado(Estados.CORRER)
	elif direction == 0:
		cambiar_estado(Estados.IDLE)
func logica_jumping() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation_player.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.y < 0:
		animation_player.frame = 0
	else:
		animation_player.frame = 1
	if is_on_floor():
		if Input.get_axis("ui_left", "ui_right") != 0:
			cambiar_estado(Estados.WALKING)
		else:
			cambiar_estado(Estados.IDLE)
func logica_agachado() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	if not Input.is_action_pressed("ui_down"):
		cambiar_estado(Estados.IDLE)

func _revisar_pisado() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider == null or not is_instance_valid(collider):
			continue
		if collider.has_method("morir"):
			if collision.get_normal().y < -0.5:
				collider.morir()
				velocity.y = JUMP_VELOCITY * 0.50

func logica_correr() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * RUN_SPEED
		animation_player.flip_h = direction < 0
	if Input.is_action_pressed("ui_down"):
		cambiar_estado(Estados.AGACHADO)
	elif Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
		cambiar_estado(Estados.JUMPING)
	elif not Input.is_action_pressed("correr"):
		if direction != 0:
			cambiar_estado(Estados.WALKING)
		else:
			cambiar_estado(Estados.IDLE)
	elif direction == 0:
		cambiar_estado(Estados.IDLE)
