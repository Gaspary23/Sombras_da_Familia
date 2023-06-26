extends Area2D

signal radio_switch

onready var sprite = $AnimatedSprite
onready var sound = $Monster_Theme
var touching_player = false
var is_using = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touching_player):
		emit_signal("radio_switch")
		is_using = not is_using
	
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Radio_body_entered(_body: Node) -> void:
	touching_player = true


func _on_Radio_body_exited(_body: Node) -> void:
	touching_player = false
