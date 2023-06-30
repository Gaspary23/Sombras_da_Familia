extends "res://NPC/NPC.gd"

func _ready():
	speed = 150
	wait_time = 3.3
	work_time = 9.2
	set_timers(wait_time, work_time)

func set_timers(wait_time, work_time):
	.set_timers(wait_time, work_time)
