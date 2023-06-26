extends KinematicBody2D

export (int) var speed := 200
enum State {working, waiting, checking, walking}

onready var sprite = $AnimatedSprite
onready var motion = Vector2.ZERO
onready var initial_pos = position
onready var obj_pos: Vector2
onready var target_pos: Vector2

var current_state = State.waiting
var suspission_level = 0
var standBy = false
var timer := Timer.new()
var tween 


func _physics_process(_delta):
	state_machine()
	
	if (suspission_level > 30):
		current_state = State.checking


func state_machine():
	match current_state:
		State.checking: # Look for player
			print("DIE")
		
		State.waiting: # Remain idle
			yield(timer, "timeout")
			standBy = false
			target_pos = obj_pos
			current_state = State.walking
		
		State.walking: # Go to target
			if target_pos.x - position.x > 0:
				motion.x = 1
			elif target_pos.x - position.x < 0:
				motion.x = -1
			
			if (is_close_to_target()):
				motion.x = 0
				if (standBy):
					current_state = State.waiting 
				else:
					current_state = State.working 
			get_side_movement()
			motion = move_and_slide(motion, Vector2.UP)

		State.working: # Do work
			yield(timer, "timeout")
			standBy = true
			target_pos = initial_pos
			current_state = State.walking


func is_close_to_target():
	return (position.x < target_pos.x + 3 and position.x > target_pos.x - 3)


func get_side_movement():
	motion.x *= speed
	if motion.x > 0:
		sprite.play("right")
	elif motion.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.play("front")


func squash_and_stretch():
	tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.25,0.75), 0.1)
	tween.tween_property(sprite, "scale", Vector2(1,1), 0.1)


func set_obj_pos(pos: Vector2):
	obj_pos = pos


func _on_timer_timeout() -> void:
	queue_free()

func _ready():
	timer.set_wait_time(5)
	timer.set_one_shot(false)
	self.add_child(timer)
	timer.start()
