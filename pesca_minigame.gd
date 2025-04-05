extends Node2D

@onready var back: ColorRect = $back
@onready var peixe: ColorRect = $back/peixe
@onready var player: ColorRect = $back/player
@onready var peixes_label: Label = $"../quantidade_peixe"

var speed: float = 200.0
var ativo := false
var callback: Callable

func _ready():
	player.position.x = 0
	visible = false

func _process(delta):
	if not ativo:
		return
	var new_x = player.position.x + speed * delta
	new_x = clamp(new_x, 0, back.size.x - player.size.x)
	player.position.x = new_x

func _incrementar_peixes():
	var texto = peixes_label.text
	var numero = int(texto.strip_edges())
	numero += 1
	peixes_label.text = str(numero)

func _input(event):
	if not ativo:
		return
	if event.is_action_pressed("ui_accept"):
		var sucesso = player.get_global_rect().intersects(peixe.get_global_rect())
		if sucesso:
			print("Peixe pescado!")
			_incrementar_peixes()
		else:
			print("Falhou a pesca!")
		ativo = false
		visible = false
		if callback:
			callback.call(sucesso)

func iniciar_minigame(_callback: Callable):
	ativo = true
	visible = true
	player.position.x = 0
	callback = _callback
