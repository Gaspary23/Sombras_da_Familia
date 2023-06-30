extends "res://NPC/NPC.gd"

var animation_timer
var animation_done = true
var door_pos
var target_floor: int

func _ready():
	speed = 200
	wait_time = 0.5
	work_time = 5.2
	set_timers(wait_time, work_time)
	
	animation_timer = Timer.new()
	animation_timer.set_one_shot(true)
	animation_timer.set_wait_time(1)
	animation_timer.connect("timeout", self, "_on_timer_timeout")
	add_child(animation_timer)


func set_timers(wait_time, work_time):
	.set_timers(wait_time, work_time)


func set_door_pos(pos):
	door_pos = pos


func go_to_target_floor():
	target_pos = door_pos
	if (not is_close_to_targetX()):
		walk_to_target()
	else:
		position.x = door_pos.x
		motion = Vector2.ZERO
		sprite.hide()
		animation_done = false
		if (animation_timer.is_stopped()):
			animation_timer.start()


func _on_timer_timeout():
	sprite.show()
	animation_done = true
	
	match (target_floor):
		1:
			position = door_pos 
			target_pos = stairs_pos
		2:
			position.x = door_pos.x
			position.y = obj_pos.y
			target_pos = obj_pos


func check_basement():
	if (position.y < door_pos.y):
		target_floor = 1
		go_to_target_floor()
	else:
		.check_basement()


func go_work():
	if (position.y < door_pos.y + 3 and position.y > door_pos.y - 3):
		position.y = door_pos.y
		target_floor = 2
		go_to_target_floor()
	else:
		.go_work()


func update_suspicion():
	if (not animation_done):
		checking_level.hide()
	else:
		.update_suspicion()
