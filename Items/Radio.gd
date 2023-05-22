extends Area2D

onready var sound = $Monster_Theme
var touchingPlayer = false
var playing = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		
		playing = not playing
		print("R:",playing)
		
	if (playing):
		sound.play()


func _on_Radio_body_entered(_body: Node) -> void:
	print("R enter")
	touchingPlayer = true


func _on_Radio_body_exited(_body: Node) -> void:
	print("R exit")
	touchingPlayer = false
