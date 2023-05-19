extends Area2D
class_name Washing_Machine

export var interaction_parent: NodePath

onready var sound = $Washing
var touchingPlayer = false
var playing = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		
		playing = not playing
		print(playing)
		
	if (playing):
		sound.play()


func _on_Washing_Machine_body_entered(_body: Node) -> void:
	touchingPlayer = true


func _on_Washing_Machine_body_exited(_body: Node) -> void:
	touchingPlayer = false
