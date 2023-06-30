extends "res://NPC/NPC.gd"

var door_pos
var animation_timer

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

func go_to_first_floor():
	target_pos = door_pos
	if (not is_close_to_targetX()):
		walk_to_target()
	else:
		position.x = door_pos.x
		motion = Vector2.ZERO
		sprite.stop()
		sprite.play("front")
		if (animation_timer.is_stopped()):
			animation_timer.start()
		sprite.hide()


func _on_timer_timeout():
	sprite.show()
	checking_level.show()
	position = door_pos 
	target_pos = stairs_pos


func check_basement():
	if (position.y < door_pos.y):
		go_to_first_floor()
	else:
		.check_basement()


func update_suspicion():
	if (animation_timer.time_left != 0):
		checking_level.hide()
	else:
		.update_suspicion()
