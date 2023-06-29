extends KinematicBody2D

onready var sprite = $Sprite
onready var sound = $AudioStreamPlayer
var tween


func _on_Player_hide_wardrobe():
	squash_and_stretch()
	sound.play()


func squash_and_stretch():
	tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.25,1), 0.1)
	tween.tween_property(sprite, "scale", Vector2(1,1), 0.1)
