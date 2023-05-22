extends Area2D

onready var sound = $Washing
var touchingPlayer = false
var playing = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		
		playing = not playing
		print("W:",playing)
		
	if (playing):
		sound.play()


func _on_Washing_Machine_body_entered(_body: Node) -> void:
	print("W enter")
	touchingPlayer = true


func _on_Washing_Machine_body_exited(_body: Node) -> void:
	print("W exit")
	touchingPlayer = false
