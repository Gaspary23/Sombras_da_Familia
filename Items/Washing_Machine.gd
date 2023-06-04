extends Area2D

signal washing_machine_using
onready var sound = $Washing
var touchingPlayer = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("washing_machine_using")
		if (not sound.is_playing()):
			sound.play()
		else:
			sound.stop()


func _on_Washing_Machine_body_entered(_body: Node) -> void:
	touchingPlayer = true


func _on_Washing_Machine_body_exited(_body: Node) -> void:
	touchingPlayer = false


func _on_Radio_radio_playing() -> void:
	if sound.is_playing():
		emit_signal("washing_machine_using")
		sound.stop()
