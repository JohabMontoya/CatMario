extends PanelContainer

@onready var texto_dialogo = $RichTextLabel

var lineas_texto: Array[String] = []
var linea_actual: int = 0

func _ready() -> void:
	hide()

func iniciar_dialogo(textos: Array[String]):
	lineas_texto = textos
	linea_actual = 0
	show()
	mostrar_linea()

func mostrar_linea():
	if(linea_actual < lineas_texto.size()):
		texto_dialogo.text = lineas_texto[linea_actual]
	else:
		hide()


func _input(event: InputEvent) -> void:
	if(visible and event.is_action_pressed("Interact")):
		linea_actual += 1
		mostrar_linea()
