extends Control

onready var sound = $ButtonClick
var is_paused = false setget set_is_paused


func _ready():
	$CenterContainer/VBoxContainer/Resume.grab_focus()


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = not is_paused


func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_Resume_pressed():
	self.is_paused = false


func _on_Return_to_Menu_pressed():
	sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	self.is_paused = false
	get_tree().change_scene("res://Game/Menu.tscn")


func _on_Quit_pressed():
	sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()
