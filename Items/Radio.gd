extends Area2D

signal radio_playing

onready var sprite = $AnimatedSprite
onready var sound = $Monster_Theme
var touchingPlayer = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		emit_signal("radio_playing")
		if (not sound.is_playing()):
			sound.play()
			sprite.play("On")
		else:
			sound.stop()
			sprite.play("Off")


func _on_Radio_body_entered(_body: Node) -> void:
	touchingPlayer = true


func _on_Radio_body_exited(_body: Node) -> void:
	touchingPlayer = false


func _on_Washing_Machine_washing_machine_using() -> void:
	if sound.is_playing():
		emit_signal("radio_playing")
		sound.stop()
