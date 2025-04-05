extends AnimatedSprite2D

func _ready():
	play("idle")  

func _process(delta):
	if Input.is_action_pressed("jogar"):
		play("jogando")
