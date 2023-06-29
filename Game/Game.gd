extends Node2D

# Game Control
onready var game_over_sound = $gameOverSound
onready var hud = $HUD
# NPC's
onready var child = $Level/Child
onready var father = $Level/Father
onready var mother = $Level/Mother
# Items
onready var arcade = $Level/Scenery/Arcade
onready var heater = $Level/Scenery/Heater
onready var lawn_mower = $Level/Scenery/Lawn_Mower
onready var radio = $Level/Scenery/Radio
onready var washing_machine = $Level/Scenery/Washing_Machine

var player : KinematicBody2D
var progress_bars : CanvasLayer
var stairs_pos: Position2D
var current_scene
var prev_time
var inc_diff_time = 30


func _physics_process(_delta: float):
	check_power() # Electricity resource management
	check_suspicion() # NPC suspicion
	increase_difficulty() # Make game harder
	check_game_over()


func check_power():
	# Child control
	if (arcade.touching_child):
		if (heater.is_using):
			arcade.is_using = false
		else:
			arcade.is_using = true
	
	# Father Control
	if (lawn_mower.touching_father):
		if (heater.is_using):
			lawn_mower.is_using = false
		else:
			lawn_mower.is_using = true
	
	# Mother control
	if (washing_machine.touching_mother):
		if (radio.is_using):
			washing_machine.is_using = false
		else:
			washing_machine.is_using = true


func check_suspicion():
	# Child control
	if (child.is_working() and not arcade.is_using):
		child.suspicion_level.value += 1
	elif (not child.is_checking()):
		child.suspicion_level.value -= 0.1
	
	# Father control
	if (father.is_working() and not lawn_mower.is_using):
		father.suspicion_level.value += 0
	elif (not father.is_checking()):
		father.suspicion_level.value -= 0.1
	
	# Mother control
	if (mother.is_working() and not washing_machine.is_using):
		mother.suspicion_level.value += 0
	elif (not mother.is_checking()):
		mother.suspicion_level.value -= 0.1


func increase_difficulty():
	var current_time = OS.get_unix_time()
	var elapsed_time = current_time - prev_time
	
	if (elapsed_time - inc_diff_time >= 0):
		prev_time = current_time
		hud.increase_difficulty()


func check_game_over():
	if (progress_bars.madness_bar.value >= 100 
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
	stairs_pos = current_scene.get_node("Scenery/Stairs")
	progress_bars = get_node("HUD")
	
	child.set_targets_pos(arcade.position, stairs_pos.position)
	father.set_targets_pos(lawn_mower.position, stairs_pos.position)
	mother.set_targets_pos(washing_machine.position, stairs_pos.position)
