extends Area2D

signal washing_machine_using
onready var sound = $Washing
var touchingPlayer = false
var playingSound = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("washing_machine_using")
		playingSound = not playingSound
		if (playingSound):
			sound.play()
		else:
			sound.stop()


func _on_Washing_Machine_body_entered(_body: Node) -> void:
	touchingPlayer = true


func _on_Washing_Machine_body_exited(_body: Node) -> void:
	touchingPlayer = false
