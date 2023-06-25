extends KinematicBody2D

export (int) var speed := 200
enum State {working,waiting,checking,walking}

onready var sprite = $AnimatedSprite
onready var motion = Vector2.ZERO
onready var initialPos = position
onready var objPos: Vector2
onready var targetPos: Vector2

var currentState = State.waiting
var levelOfSuspission = 0
var standBy = false


func _physics_process(_delta):
	state_machine()
	
	if (levelOfSuspission > 30):
		currentState = State.checking


func state_machine():
	match currentState:		
		State.checking: # Look for player
			print("DIE")
		
		State.waiting: # Remain idle
			yield(get_tree().create_timer(1), "timeout")
			standBy = false
			targetPos = objPos
			currentState = State.walking
		
		State.walking: # Go to target
			if targetPos.x - position.x > 0:
				motion.x = 1
			elif targetPos.x - position.x < 0:
				motion.x = -1
			else:
				motion.x = 0
			
			get_side_movement()
			motion = move_and_slide(motion, Vector2.UP)
			stop_close_to_target()

		State.working: # Do work
			yield(get_tree().create_timer(2), "timeout")
			standBy = true
			targetPos = initialPos
			currentState = State.walking


func stop_close_to_target():
	if((position.x < targetPos.x + 3 and position.x > targetPos.x - 3) and standBy == false):
		currentState = State.working 
	if((position.x < targetPos.x + 3 and position.x > targetPos.x - 3) and standBy == true):
		currentState = State.waiting 


func get_side_movement():
	motion.x *= speed
	# if motion.x > 0:
	# 	sprite.play("right")
	# elif motion.x < 0:
	# 	sprite.play("left")
	# else:
	# 	sprite.stop()
	# 	sprite.play("down")
	# 	sprite.frame = 0


func set_objPos(pos: Vector2):
	objPos = pos
