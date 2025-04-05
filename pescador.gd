extends Node2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var minigame = $"../../pesca-minigame"

var pode_jogar := true
var playing_forward := true
var esperando_minigame := false

func _ready():
	anim_sprite.play("idle")
	anim_sprite.animation_finished.connect(_on_animation_finished)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE and pode_jogar:
			pode_jogar = false
			if playing_forward:
				anim_sprite.speed_scale = 1
				anim_sprite.play("jogando")
				playing_forward = false
			elif anim_sprite.animation == "idle_agua":
				# Iniciar minigame antes de puxar
				esperando_minigame = true
				minigame.iniciar_minigame(_minigame_concluido)

func _on_animation_finished():
	if anim_sprite.animation == "jogando":
		anim_sprite.play("idle_agua")
		pode_jogar = true
	elif anim_sprite.animation == "puxando":
		anim_sprite.play("idle")
		pode_jogar = true

func _minigame_concluido(sucesso: bool):
	if esperando_minigame:
		esperando_minigame = false
		anim_sprite.play("puxando")
		playing_forward = true
