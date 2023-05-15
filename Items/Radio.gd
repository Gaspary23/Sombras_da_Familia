extends Area2D
class_name Radio

onready var sound = $JumpSound
export var interaction_parent: NodePath

var touchingPlayer = false
var playing = false


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		playing = not playing
		
	if (playing):
		sound.play()


func _on_Radio_body_entered(_body: Node) -> void:
	touchingPlayer = true


func _on_Radio_body_exited(_body: Node) -> void:
	touchingPlayer = false
