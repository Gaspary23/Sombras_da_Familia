extends Node2D

signal increase_difficulty

onready var game_over_sound = $gameOverSound
onready var NPC = $Level/NPC
onready var Washing_Machine = $Level/Scenery/Washing_Machine

var player : KinematicBody2D
var progress_bars : CanvasLayer
var current_scene
var prev_time
var inc_diff_time = 30


func _physics_process(_delta: float):
	check_suspission()
	increase_difficulty()
	check_game_over()


func check_suspission():
	if(NPC.is_close_to_target() and Washing_Machine.is_using):
		NPC.suspission_level += 0.1


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


func goto_scene(path: String):
	var world := get_child(0)
	world.free()
	var res := ResourceLoader.load(path)
	current_scene = res.instance()
	get_tree().get_root().add_child(current_scene)


func _ready():
	prev_time = OS.get_unix_time()
	current_scene = get_child(0) # pega o Level1, etc
	player = current_scene.get_node("Player")
	progress_bars = get_node("HUD")
	
	NPC.set_obj_pos(Washing_Machine.position)
