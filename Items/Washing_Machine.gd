extends Area2D

signal washing_machine_using

onready var sprite = $AnimatedSprite
onready var sound = $Washing
var touchingPlayer = false
var is_using = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("washing_machine_using")
		is_using = not is_using
	
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Washing_Machine_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		touchingPlayer = true


func _on_Washing_Machine_body_exited(body: Node) -> void:
	if (body.name == "Player"):
		touchingPlayer = false


func _on_Radio_radio_playing() -> void:
	# If radio is on, turn WM off
	is_using = false
