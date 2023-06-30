extends "res://NPC/NPC.gd"

func _ready():
	speed = 100
	wait_time_bound = Vector2(3.5, 6.5)
	work_time_bound = Vector2(5, 10)
	randomize_variables()


func _process(_delta):
	if (is_working()):
		sprite.stop()
		sprite.play("left")
