extends Area2D

signal heater_on

onready var sprite = $AnimatedSprite
onready var sound = $AudioStreamPlayer
var touchingPlayer = false
var is_using = false

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("heater_on")
		is_using = not is_using
	
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Heater_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		touchingPlayer = true

func _on_Heater_body_exited(body: Node) -> void:
	if (body.name == "Player"):
		touchingPlayer = false
