extends KinematicBody2D

export (int) var speed := 200
enum State {working, waiting, checking, walking}

onready var sprite = $AnimatedSprite
onready var motion = Vector2.ZERO
onready var initial_pos = position
onready var obj_pos: Vector2
onready var target_pos: Vector2
onready var stairs_pos: Vector2
onready var suspicion_level = $Suspicion_Level
onready var checking_level = $Checking_Level

var current_state = State.waiting
var standBy = false
var timer := Timer.new()
var wait_time = 5
var tween


func _physics_process(_delta):
	#stairs_pos.x = 600
	#stairs_pos.y = 531
	state_machine()
	update_suspicion()


func state_machine():
	match current_state:
		State.checking: # Look for player
			checking_level.value -= 0.5
			target_pos = stairs_pos
			print(stairs_pos)
			
			if target_pos.x - position.x > 0:
				motion.x = 1
			elif target_pos.x - position.x < 0:
				motion.x = -1
			if (is_close_to_target()):				
				motion.x = 0
				if target_pos.y - position.y > 0:
					motion.y = 1
				elif target_pos.x - position.y < 0:
					motion.y = -1
				if(is_close_to_target2()):
					motion.y = 0
					if (standBy):
						current_state = State.waiting 
					else:
						current_state = State.working 
				get_vertical_movement()
				motion = move_and_slide(motion, Vector2.UP)
			get_side_movement()
			motion = move_and_slide(motion, Vector2.UP)
			if (checking_level.value == 0):
				current_state = State.working
				# return to some pos
		
		State.waiting: # Remain idle
			standBy = false
			target_pos = obj_pos
			current_state = State.walking
		
		State.walking: # Go to target
			if target_pos.y - position.y > 0:
				motion.y = 1
			elif target_pos.y - position.y < 0:
				motion.y = -1
			
			if (is_close_to_target2()):
				motion.y = 0
				if target_pos.x - position.x > 0:
					motion.x = 1
				elif target_pos.x - position.x < 0:
					motion.x = -1
				if(is_close_to_target()):
					motion.x = 0
					if (standBy):
						current_state = State.waiting 
					else:
						current_state = State.working 
				get_side_movement()
				motion = move_and_slide(motion, Vector2.UP)
			get_vertical_movement()
			motion = move_and_slide(motion, Vector2.UP)

		State.working: # Do work
			standBy = true
			
			if (suspicion_level.value == 100):
				checking_level.value = 100
				current_state = State.checking
			#target_pos = initial_pos
			#current_state = State.walking


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
	print((position.x < target_pos.x + 3 and position.x > target_pos.x - 3))
	return (position.x < target_pos.x + 3 and position.x > target_pos.x - 3)
	
func is_close_to_target2():
	return (position.y < target_pos.y + 3 and position.y > target_pos.y - 3)


func get_side_movement():
	motion.x *= speed
	if motion.x > 0:
		sprite.play("right")
	elif motion.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.play("front")
		
func get_vertical_movement():
	motion.y *= speed
	if motion.y > 0:
		sprite.play("right")
	elif motion.y < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.play("front")


func set_obj_pos(pos: Vector2):
	obj_pos = pos


func is_working():
	return current_state == State.working


func is_checking():
	return current_state == State.checking


func _ready():
	checking_level.value = 0
	self.add_child(timer)
	timer.start()
