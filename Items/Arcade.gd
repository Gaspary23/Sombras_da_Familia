extends Area2D

onready var sprite = $AnimatedSprite
onready var video = $VideoPlayer
var touching_child = false
var is_using = false


func _process(_delta: float) -> void:
	if (is_using):
		if (not video.is_playing()):
			video.play()
		sprite.play("On")
	else:
		video.stop()
		sprite.play("Off")


func _on_Arcade_body_entered(_body):
	touching_child = true
	is_using = true


func _on_Arcade_body_exited(_body):
	touching_child = false
	is_using = false
