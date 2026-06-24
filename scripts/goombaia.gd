extends CharacterBody2D

@onready var animated_sprite : = $AnimatedSprite2D
@onready var navegation_agent : = $NavigationAgent2D
const SPEED = 300.0
var player: CharacterBody2D

func _ready() -> void:
	animated_sprite.play("caminar")
	player = get_tree().get_first_node_in_group("jugador")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = to_local(navegation_agent.get_next_path_position()).normalized()
	velocity.x = direction.x * SPEED
	
		
	

	move_and_slide()


func _on_timer_timeout() -> void:
	navegation_agent.target_position = player.global_position
