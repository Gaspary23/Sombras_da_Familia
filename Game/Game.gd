extends Node2D

var player : KinematicBody2D
var progress_bars : CanvasLayer

var currentScene = null

onready var sound = $gameOverSound

var time_start = 0
var time_now = 0

var count_time = true
signal increase_difficulty
var increment_time_value = 60

func _ready() -> void:
	time_start = OS.get_unix_time()
	currentScene = get_child(0) # pega o Level1, etc
	player = currentScene.get_node("Player")
	progress_bars = get_node("HUD")


func _physics_process(_delta: float) -> void:
	time_now = OS.get_unix_time()
	var time_elapsed: int = time_now - time_start
	if time_elapsed % increment_time_value == 0 and time_elapsed != 0 and count_time:
		count_time = false
		emit_signal("increase_difficulty")
	
	if time_elapsed % increment_time_value != 0 and !count_time:
		count_time = true
	
	if progress_bars.sanity_bar.value <= 0 or progress_bars.suspect_bar.value <= 0:
		if (not sound.is_playing()):
			sound.play()
		else:
			sound.stop()
		get_tree().change_scene("res://GameOver.tscn")


func goto_scene(path: String):
	var world := get_child(0)
	world.free()
	var res := ResourceLoader.load(path)
	currentScene = res.instance()
	get_tree().get_root().add_child(currentScene)
