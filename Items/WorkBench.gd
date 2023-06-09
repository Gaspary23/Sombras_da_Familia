extends KinematicBody2D

onready var sprite = $AnimatedSprite
var tween

func _on_Player_hide_workbench():
	squash_and_stretch()
	if (sprite.animation == "free"):
		sprite.play("occupied")
	else:
		sprite.play("free")


func squash_and_stretch():
	tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.25,1), 0.1)
	tween.tween_property(sprite, "scale", Vector2(1,1), 0.1)
