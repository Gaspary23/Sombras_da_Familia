extends Control

onready var sound = $ButtonClick

func _on_Button_pressed():
	sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Game/Game.tscn")
