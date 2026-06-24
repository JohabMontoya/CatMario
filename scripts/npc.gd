extends CharacterBody2D

@export var dialogo_npc: Array[String] = [
	"Move the character with the arrow keys"
]
@onready var zona_interaccion = $Area2D/CollisionShape2D
@onready var dialogo = $dialogo
@onready var textLabel = $dialogo/RichTextLabel

var jugadorCerca : bool = false
var hablando: bool = false
var linea_actual = 0

func _ready():
	dialogo.hide()


func _input(event: InputEvent):
	if(jugadorCerca and event.is_action_pressed("Interact")):
		if not hablando:
			iniciar_dialogo()
		else:
			avanzar_linea()
	pass

func iniciar_dialogo():
	hablando = true
	linea_actual = 0
	dialogo.show()
	mostrar_texto()
	pass

func avanzar_linea():
	linea_actual += 1
	if(linea_actual < dialogo_npc.size()):
		mostrar_texto()
	else:
		dialogo.hide()
		hablando = false
	pass

func mostrar_texto():
	textLabel.text = dialogo_npc[linea_actual]


func _on_area_2d_body_entered(body: Node2D) -> void:
	jugadorCerca = true
	pass 

func _on_area_2d_body_exited(body: Node2D) -> void:
	jugadorCerca = false
	if(hablando):
		hablando = false
		dialogo.hide()
	pass # Replace with function body.
