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
var wait_time = 5
var tween


func _physics_process(_delta):
	state_machine()
	update_suspicion()


func state_machine():
	if (not is_close_to_target()):
		walk_to_target()
	else:
		motion.x = 0
	
	match current_state:
		State.checking: # Look for player
			checking_level.value -= 0.1
			
			if (checking_level.value == 0):
				target_pos = obj_pos
				current_state = State.working
		
		State.waiting: # Remain idle
			target_pos = obj_pos
			if (is_close_to_target()):
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


func walk_to_target():
	if target_pos.x - position.x > 0:
		motion.x = 1
	elif target_pos.x - position.x < 0:
		motion.x = -1
	
	motion.x *= speed
	sprite_animation()
	motion = move_and_slide(motion, Vector2.UP)


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


func is_close_to_target():
	return (position.x < target_pos.x + 3 and position.x > target_pos.x - 3)


func sprite_animation():
	if motion.x > 0:
		sprite.play("right")
	elif motion.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.play("front")


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
