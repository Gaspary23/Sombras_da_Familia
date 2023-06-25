extends Area2D

signal washing_machine_using

onready var sprite = $AnimatedSprite
onready var sound = $Washing
var touchingPlayer = true
var WMon = true
onready var my_nodes_local_position = position


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("washing_machine_using")
		WMon = not WMon
		if (not sound.is_playing()):
			sound.play()
			sprite.play("On")
		else:
			sound.stop()
			sprite.play("Off")


func _on_Washing_Machine_body_entered(body: Node) -> void:
	if(body.name == "NPC"):
		emit_signal("washing_machine_using")
	touchingPlayer = true


func _on_Washing_Machine_body_exited(_body: Node) -> void:
	touchingPlayer = false


func _on_Radio_radio_playing() -> void:
	if sound.is_playing():
		emit_signal("washing_machine_using")
		sound.stop()
