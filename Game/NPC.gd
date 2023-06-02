extends KinematicBody2D


enum State {action,waiting,checking,walking}

var levelOfSuspission: int = 0
var taskTime: int = 0
var currentState: int = State.waiting
	

func scripted() -> int:
	if(currentState	== State.waitng):
		yield(get_tree().create_timer(1), "timeout")
		return 0
	if(currentState	== State.action):
		return 0
	if(currentState	== State.checking):
		return 0
	if(currentState	== State.walking):
		return 0
	return 0
	
	
func _ready():
	pass 
