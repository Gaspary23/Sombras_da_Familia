extends Node2D

var player : KinematicBody2D
var progress_bars : CanvasLayer

var currentScene = null

onready var sound = $gameOverSound


func _ready() -> void:
	currentScene = get_child(0) # pega o Level1, etc
	player = currentScene.get_node("Player")
	progress_bars = get_node("HUD")


func _physics_process(_delta: float) -> void:
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
