class_name NPC
extends KinematicBody2D

enum State {action,waiting,checking,walking}
export (int) var speed := 200

var levelOfSuspission: int = 0
var taskTime: int = 0
var currentState: int = State.waiting
onready var objPos: Vector2
onready var velocity = Vector2.ZERO
onready var targetPos = $CollisionShape2D.position
onready var currentPos = $CollisionShape2D.position
onready var initialPos = $CollisionShape2D.position
var standBy = false


func setPos(pos: Vector2):
	objPos = pos


func moveToObject():
	velocity = move_and_slide(velocity, Vector2.UP)


func scripted():
	if (levelOfSuspission > 30):
		self.currentState = State.checking
	elif(currentState == State.waiting):
		yield(get_tree().create_timer(1), "timeout")
		standBy = false
		targetPos = objPos
		currentPos = position
		currentState = State.walking
	elif(currentState == State.action):
		yield(get_tree().create_timer(2), "timeout")
		standBy = true
		targetPos = initialPos
		self.currentState == State.walking
	elif(currentState == State.checking):
		print("DIE!!")
	elif(currentState == State.walking):
		currentPos = position
		#print (currentPos)
		if targetPos.x - currentPos.x > 0:
			velocity.x = 1
		elif targetPos.x - currentPos.x < 0:
			velocity.x = -1
		else:
			velocity.x = 0
		#velocity =  targetPos - initialPos
		velocity.x *= speed
		#print(velocity)
		if(targetPos.x != currentPos.x):
			self.moveToObject()
		if(targetPos.x == currentPos.x && standBy == false):
			self.currentState == State.action 
		if(targetPos.x == currentPos.x && standBy == true):
			self.currentState == State.waiting 
