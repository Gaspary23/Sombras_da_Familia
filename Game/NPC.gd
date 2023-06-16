class_name NPC
extends KinematicBody2D


enum State {action,waiting,checking,walking}

var levelOfSuspission: int = 0
var taskTime: int = 0
var currentState: int = State.waiting
onready var objPos: Vector2
onready var targetPos = $CollisionShape2D.position
onready var velocity = Vector2.ZERO
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
	elif(currentState	== State.waiting):
		yield(get_tree().create_timer(1), "timeout")
		standBy = false
		targetPos = objPos
		currentPos = position
		currentState = State.walking
		print(currentState)
	elif(currentState	== State.action):
		yield(get_tree().create_timer(2), "timeout")
		standBy = true
		targetPos = initialPos
		self.currentState == State.walking
	elif(currentState	== State.checking):
		print("DIE!!")
	elif(currentState	== State.walking):
		print(targetPos.y)
		print(currentPos.y)
		currentPos = position
		velocity.x = (targetPos.x - currentPos.x)/5
		if(targetPos.x != currentPos.x):
			self.moveToObject()
		if(targetPos.x == currentPos.x && standBy == false):
			print("Cheguei Aqui")
			self.currentState == State.action 
		if(targetPos.x == currentPos.x && standBy == true):
			print("Cheguei Aqui2")
			self.currentState == State.waiting 
				

	
	
func _ready():
	pass 
