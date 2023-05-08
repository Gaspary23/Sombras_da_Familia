extends Area2D
class_name Radio

onready var sound = $JumpSound

export var interaction_parent: NodePath

var playing = false

func _process(delta: float) -> void:
	if (interaction_parent != null and Input.is_action_just_pressed("interact")):
		playing = not playing
		print(playing)
		if (playing):
			sound.play()
