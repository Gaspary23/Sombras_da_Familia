extends KinematicBody2D
class_name Player

export (int) var speed := 200

onready var target = position
onready var sprite = $Sprite
onready var door_sound = $Door
var motion = Vector2.ZERO
var hidden = false
var tween


func get_side_input():
	motion.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	motion.x *= speed
	if motion.x > 0:
		sprite.play("right")
	elif motion.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.play("down")
		sprite.frame = 0


func squash_and_stretch():
	tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.25,0.75), 0.1)
	tween.tween_property(sprite, "scale", Vector2(1,1), 0.1)


func _physics_process(_delta):
	if (Input.is_action_just_pressed("interact")):
		squash_and_stretch()
		if(is_on_wall()):
			door_sound.play()
			tween.tween_property(sprite, "visible", hidden, 0.01)
			hidden = not hidden
	
	if(visible):
		get_side_input()
		motion = move_and_slide(motion, Vector2.UP)
