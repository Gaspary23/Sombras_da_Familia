extends Area2D

onready var sprite = $AnimatedSprite
onready var sound = $AudioStreamPlayer
var touching_father = false
var is_using = false


func _process(_delta: float) -> void:
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Lawn_Mower_body_entered(_body):
	touching_father = true
	is_using = true


func _on_Lawn_Mower_body_exited(_body):
	touching_father = false
	is_using = false
