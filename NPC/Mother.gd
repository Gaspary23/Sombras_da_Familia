extends "res://NPC/NPC.gd"

func _ready():
	speed = 150
	wait_time_bound = Vector2(4, 8.5)
	work_time_bound = Vector2(6.5, 11.5)
	randomize_variables()


func set_timers(wait_time, work_time):
	.set_timers(wait_time, work_time)
