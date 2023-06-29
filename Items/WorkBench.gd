extends KinematicBody2D

onready var sprite = $AnimatedSprite

func _on_Player_hide_workbench():
	if (sprite.animation == "free"):
		sprite.play("occupied")
	else:
		sprite.play("free")
