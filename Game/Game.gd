extends Node2D

signal increase_difficulty

onready var game_over_sound = $gameOverSound
onready var NPC = $Level/NPC
onready var Washing_Machine = $Level/Scenery/Washing_Machine

var player : KinematicBody2D
var progress_bars : CanvasLayer
var currentScene
var prev_time
var inc_diff_time = 30


func _physics_process(_delta: float):
	_check()
	increase_difficulty()
	check_game_over()


func _check():
	if(NPC.position.x < NPC.objPos.x + 3 and NPC.position.x > NPC.objPos.x - 3 and Washing_Machine.is_using):
		NPC.levelOfSuspission += 0.2


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
	currentScene = res.instance()
	get_tree().get_root().add_child(currentScene)


func _ready():
	prev_time = OS.get_unix_time()
	currentScene = get_child(0) # pega o Level1, etc
	player = currentScene.get_node("Player")
	progress_bars = get_node("HUD")
	
	NPC.set_objPos(Washing_Machine.position)
