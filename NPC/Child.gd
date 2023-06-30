extends "res://NPC/NPC.gd"

func _ready():
	speed = 200
	wait_time = 4.5
	work_time = 5.2
	set_timers(wait_time, work_time)
	#12.5 (50%)

func set_timers(wait_time, work_time):
	.set_timers(wait_time, work_time)
