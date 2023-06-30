extends "res://NPC/NPC.gd"

func _ready():
	speed = 150
	wait_time_bound = Vector2(4, 6.5)
	work_time_bound = Vector2(8.5, 11.5)
	randomize_variables()

