extends Area2D

signal arcade_switch

onready var sprite = $AnimatedSprite
onready var sound = $AudioStreamPlayer
var touching_child = false
var is_using = false


func _process(_delta: float) -> void:
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Arcade_body_entered(_body):
	emit_signal("arcade_switch")
	touching_child = true
	is_using = true


func _on_Arcade_body_exited(_body):
	touching_child = false
	is_using = false
