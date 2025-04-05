extends Node2D

@onready var back: ColorRect = $back
@onready var peixe: ColorRect = $back/peixe
@onready var player: ColorRect = $back/player
@onready var peixes_label: Label = $"../quantidade_peixe"  # Ajuste o caminho se necessário

var speed: float = 200.0

func _ready():
	player.position.x = 0

func _process(delta):
	var new_x = player.position.x + speed * delta
	new_x = clamp(new_x, 0, back.size.x - player.size.x)
	player.position.x = new_x

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if player.get_global_rect().intersects(peixe.get_global_rect()):
			print("Peixe pescado!")
			_incrementar_peixes()
		else:
			print("Falhou a pesca!")

func _incrementar_peixes():
	var texto = peixes_label.text
	var numero = int(texto.strip_edges())
	numero += 1
	peixes_label.text = str(numero)
