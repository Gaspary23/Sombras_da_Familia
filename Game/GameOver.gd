extends Control

onready var sound = $ButtonClick


func _ready():
	$VBoxContainer/Try_Again.grab_focus()


func _on_Try_Again_pressed():
	sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Game/Game.tscn")


func _on_Return_to_Menu_pressed():
	sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Game/Menu.tscn")


func _on_Quit_pressed():
	sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().quit()
