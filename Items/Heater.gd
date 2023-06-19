extends Area2D

signal heater_on
#onready var sound = $Monster_Theme
var touchingPlayer = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("heater_on")
#		if (not sound.is_playing()):
#			sound.play()
#		else:
#			sound.stop()


func _on_Heater_body_entered(_body: Node) -> void:
	touchingPlayer = true

func _on_Heater_body_exited(_body: Node) -> void:
	touchingPlayer = false
