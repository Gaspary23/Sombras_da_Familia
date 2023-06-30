extends "res://NPC/NPC.gd"

func _ready():
	speed = 100
	wait_time = 4.0
	work_time = 7.5
	set_timers(wait_time, work_time)
	#7.5 (33%)

func set_timers(wait_time, work_time):
	.set_timers(wait_time, work_time)
