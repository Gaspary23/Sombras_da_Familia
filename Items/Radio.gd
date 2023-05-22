extends Area2D

onready var sound = $Monster_Theme
var touchingPlayer = false


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touchingPlayer):
		if (not sound.is_playing()):
			sound.play()
		else:
			sound.stop()


func _on_Radio_body_entered(_body: Node) -> void:
	print("R enter")
	touchingPlayer = true


func _on_Radio_body_exited(_body: Node) -> void:
	print("R exit")
	touchingPlayer = false


func is_playing() -> bool:
	print(sound.is_playing())
	return sound.is_playing()
