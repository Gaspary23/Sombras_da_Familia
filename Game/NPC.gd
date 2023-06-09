class_name NPC
extends KinematicBody2D


enum State {action,waiting,checking,walking}

var levelOfSuspission: int = 0
var taskTime: int = 0
var currentState: int = State.waiting
var targetPos: Vector2 
var velocity = Vector2.ZERO
var currentPos = $CollisionShape2D.position
var initialPos = $CollisionShape2D.position
var standBy = false
	
func setPos(position: Vector2):
	targetPos = position
	
func moveToObject():
	velocity = move_and_slide(velocity, Vector2.UP)
	
func scripted() -> int:
	if (levelOfSuspission > 30):
		self.currentState = State.checking
	if(currentState	== State.waitng):
		yield(get_tree().create_timer(1), "timeout")
		standBy = false
		self.currentState == State.walking
		return 0
	if(currentState	== State.action):
		yield(get_tree().create_timer(5), "timeout")
		standBy = true
		targetPos = initialPos
		self.currentState == State.walking
		return 0
	if(currentState	== State.checking):
		print("DIE!!")
		return 0
	if(currentState	== State.walking):
		velocity.x = (targetPos.x - currentPos.x)/5
		while(targetPos != currentPos):
			self.moveToObject()
			if(targetPos == currentPos && standBy == false):
				self.currentState == State.action 
			if(targetPos == currentPos && standBy == true):
				self.currentState == State.waiting 
			return 0
	return 0
	
	
func _ready():
	pass 
