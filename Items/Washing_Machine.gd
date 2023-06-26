extends Area2D

signal washing_machine_switch

onready var sprite = $AnimatedSprite
onready var sound = $Washing
var touching_mother = false
var is_using = false


func _process(_delta: float) -> void:
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Washing_Machine_body_entered(_body: Node) -> void:
		emit_signal("washing_machine_switch")
		touching_mother = true
		is_using = true


func _on_Washing_Machine_body_exited(_body: Node) -> void:
		touching_mother = false
		is_using = false
