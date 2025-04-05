extends Node2D

@onready var anim_sprite = $AnimatedSprite2D
var pode_jogar := true
var playing_forward := true  # true: tocar "jogando" normal; false: tocar "puxando"

func _ready():
	anim_sprite.play("idle")
	anim_sprite.animation_finished.connect(_on_animation_finished)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE and pode_jogar:
			pode_jogar = false
			if playing_forward:
				# Toca "jogando" normalmente (para depois ir para "idle_agua")
				anim_sprite.speed_scale = 1
				anim_sprite.play("jogando")
				playing_forward = false
			else:
				# Toca "puxando" (ao invés de reverter "jogando", para depois ir para "idle")
				anim_sprite.speed_scale = 1
				anim_sprite.play("puxando")
				playing_forward = true

func _on_animation_finished():
	if anim_sprite.animation == "jogando":
		# Ao terminar "jogando", vai para "idle_agua" em loop
		anim_sprite.play("idle_agua")
		pode_jogar = true
	elif anim_sprite.animation == "puxando":
		# Ao terminar "puxando", volta para "idle" em loop
		anim_sprite.play("idle")
		pode_jogar = true
 
