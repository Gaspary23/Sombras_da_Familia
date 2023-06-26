extends Node2D

signal increase_difficulty

# Game Control
onready var game_over_sound = $gameOverSound
# NPC's
onready var mother = $Level/NPC
# Items
onready var radio = $Level/Scenery/Radio
onready var washing_machine = $Level/Scenery/Washing_Machine

var player : KinematicBody2D
var progress_bars : CanvasLayer
var current_scene
var prev_time
var inc_diff_time = 30


func _physics_process(_delta: float):
	check_power() # Electricity resource management
	check_suspission() # NPC suspission
	increase_difficulty() # Make game harder
	check_game_over()


func check_power():
	if (washing_machine.touching_mother):
		if (radio.is_using):
			washing_machine.is_using = false
		else:
			washing_machine.is_using = true


func check_suspission():
	if(mother.is_working() and not washing_machine.is_using):
		mother.suspission_level += 0.1


func increase_difficulty():
	var current_time = OS.get_unix_time()
	var elapsed_time = current_time - prev_time
	
	if (elapsed_time - inc_diff_time >= 0):
		prev_time = current_time
		emit_signal("increase_difficulty")


func check_game_over():
	if (progress_bars.madness_bar.value >= 100 
	or progress_bars.suspicion_bar.value >= 100 
	or progress_bars.coldness_bar.value >= 100):
		
		if (not game_over_sound.is_playing()):
			game_over_sound.play()
		else:
			game_over_sound.stop()
		get_tree().change_scene("res://Game/GameOver.tscn")


func _ready():
	prev_time = OS.get_unix_time()
	current_scene = get_child(0) # pega o Level1, etc
	player = current_scene.get_node("Player")
	progress_bars = get_node("HUD")
	
	mother.set_obj_pos(washing_machine.position)
