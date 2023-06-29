extends KinematicBody2D

export (int) var speed
enum State {working, waiting, checking}

onready var sprite = $AnimatedSprite
onready var motion = Vector2.ZERO
onready var initial_pos = position
onready var obj_pos: Vector2
onready var target_pos: Vector2
onready var stairs_pos: Vector2
onready var suspicion_level = $Suspicion_Level
onready var checking_level = $Checking_Level

var current_state = State.waiting
var timer := Timer.new()
var look_around = false
var wait_time = 5
var tween


func _physics_process(_delta):
	state_machine()
	update_suspicion()


func state_machine():	
	match current_state:
		State.checking: # Look for player
			if (checking_level.value != 0):
				check_basement()
				checking_level.value -= 0.5
			else:
				target_pos = obj_pos
				return_to_work()
		
		State.waiting: # Remain idle
			target_pos = obj_pos
			if (not is_close_to_targetX()):
				walk_to_target()
			else:
				current_state = State.working
		
		State.working: # Do work
			sprite.stop()
			sprite.play("back")
			
			if (suspicion_level.value == 100):
				checking_level.value = 100
				target_pos = stairs_pos
				current_state = State.checking
			#target_pos = initial_pos
			#current_state = State.walking


func check_basement():
	if (not is_close_to_targetX()):
		walk_to_target()
	else:
		if (not is_close_to_targetY()):
			use_stairs()
		else:
			position.y = stairs_pos.y
			motion = Vector2(0,0)
			look_around = true
			sprite.stop()
			sprite.play("front")


func return_to_work():
	if (not is_close_to_targetY()):
		use_stairs()
	else:
		if (not is_close_to_targetX()):
			walk_to_target()
		else:
			position.x = obj_pos.x
			motion = Vector2(0,0)
			look_around = false
			current_state = State.working
			sprite.stop()
			sprite.play("back")


func update_suspicion():
	if (current_state == State.checking):
		suspicion_level.hide()
		if (checking_level.value == 0):
			checking_level.hide()
		else:
			checking_level.show()
	else: # Any other state
		checking_level.hide()
		if (suspicion_level.value == 0):
			suspicion_level.hide()
		else:
			suspicion_level.show()
	
	# Animation feedback when changing bars
	if (checking_level.value == 100 and suspicion_level.value == 100):
		squash_and_stretch()


func squash_and_stretch():
	tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.25,1.25), 0.3)
	tween.tween_property(sprite, "scale", Vector2(1,1), 0.3)


func is_close_to_targetX():
	return (position.x < target_pos.x + 3 and position.x > target_pos.x - 3)


func is_close_to_targetY():
	return (position.y < target_pos.y + 3 and position.y > target_pos.y - 3)


func walk_to_target():
	motion.y = 0
	if (target_pos.x - position.x > 0):
		motion.x = 1
	elif (target_pos.x - position.x < 0):
		motion.x = -1
	
	motion.x *= speed
	sprite_animation()
	motion = move_and_slide(motion, Vector2.UP)


func use_stairs():
	motion.x = 0
	if (target_pos.y - position.y < 0):
		motion.y = -1
	elif (target_pos.y - position.y > 0):
		motion.y = 1
	
	motion.y *= speed
	sprite_animation()
	motion = move_and_slide(motion, Vector2.UP)


func sprite_animation():
	if motion.x > 0:
		sprite.play("right")
	elif motion.x < 0:
		sprite.play("left")
	elif motion.x == 0:
		sprite.stop()
		sprite.play("front")
	
	if motion.y != 0:
		sprite.play("back")


func set_targets_pos(obj: Vector2, stairs: Vector2):
	obj_pos = obj
	stairs_pos = stairs


func is_working():
	return current_state == State.working


func is_checking():
	return current_state == State.checking


func _ready():
	checking_level.value = 0
	self.add_child(timer)
	timer.start()
