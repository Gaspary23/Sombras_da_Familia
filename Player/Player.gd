extends KinematicBody2D

signal hide_workbench


export (int) var speed := 200

onready var sprite = $Sprite
onready var door_sound = $Door
var motion = Vector2.ZERO
var hidden = false
var tween


func _physics_process(_delta):
	if (Input.is_action_just_pressed("interact")):
		squash_and_stretch()
		
		if(is_on_wall()):
			tween.tween_property(sprite, "visible", hidden, 0.01)
			hidden = not hidden
			# If player is on right side hide on workbench
			if (position > get_viewport_rect().size/2):
				emit_signal("hide_workbench")
			else: # If on left side, hide on wardrobe
				door_sound.play()
	
	if(not hidden):
		get_side_input()
		motion = move_and_slide(motion, Vector2.UP)


func get_side_input():
	motion.x = Input.get_action_strength("right")-Input.get_action_strength("left")
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
