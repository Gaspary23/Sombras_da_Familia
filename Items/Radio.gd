extends Area2D

signal radio_playing
onready var sound = $Monster_Theme
var touchingPlayer = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("radio_playing")
		if (not sound.is_playing()):
			sound.play()
		else:
			sound.stop()


func _on_Radio_body_entered(_body: Node) -> void:
	touchingPlayer = true


func _on_Radio_body_exited(_body: Node) -> void:
	touchingPlayer = false
