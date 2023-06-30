extends Control

onready var sound = $ButtonClick


func _ready():
	$VBoxContainer/Start.grab_focus()


func _on_Start_pressed():
	sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Game/Game.tscn")


func _on_Quit_pressed():
	sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().quit()
