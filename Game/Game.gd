extends Node2D

var player : KinematicBody2D
var progress_bars : CanvasLayer

onready var game_over_sound = $gameOverSound
onready var NPC = $Level/NPC
onready var WM = $Level/Scenery/Washing_Machine

var currentScene = null
var time_start = 0
var time_now = 0
var boolean = true


var count_time = true
signal increase_difficulty
var increment_time_value = 20

func _check() -> void:
	if(NPC.currentPos.x < NPC.objPos.x + 3 and NPC.currentPos.x > NPC.objPos.x - 3 and WM.WMon):
		NPC.levelOfSuspission += 0.2
		

func _ready() -> void:
	time_start = OS.get_unix_time()
	currentScene = get_child(0) # pega o Level1, etc
	player = currentScene.get_node("Player")
	progress_bars = get_node("HUD")
	NPC.setInitialPos(NPC.position)


func _physics_process(_delta: float) -> void:
	var WMPos = $Level/Scenery/Washing_Machine.position
	NPC.scripted()
	if (boolean == true):
		NPC.setPos(WMPos)
		boolean = false
		
	time_now = OS.get_unix_time()
	var time_elapsed: int = time_now - time_start
	if time_elapsed % increment_time_value == 0 and time_elapsed != 0 and count_time:
		count_time = false
		emit_signal("increase_difficulty")
	
	if time_elapsed % increment_time_value != 0 and !count_time:
		count_time = true
	
	_check()
	
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
